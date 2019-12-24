require "option_parser"
require "colorize"
require "termbox"
require "system/user"
require "system/group"
require "./colorls/*"
require "./colorls/formatters/*"

include Termbox

module Colorls
  VERSION = "0.1.1"

  # ameba:disable Metrics/CyclomaticComplexity
  def self.call(args)
    TermboxBindings.tb_init
    width = TermboxBindings.tb_width
    TermboxBindings.tb_shutdown

    option_all = false
    option_long = false
    option_report = false

    OptionParser.parse do |parser|
      parser.banner = "Usage: colorls [arguments]"
      parser.on("-a", "--all", "Show all files & folders") { option_all = true }
      parser.on("-l", "--long", "Length-wise") { option_long = true }
      parser.on("-r", "--report", "Print summary") { option_report = true }
      parser.on("-s", "--setup", "Setup & generate config files") { Colorls::Setup.call; exit }
      parser.on("-v", "--version", "Print version") { puts Colorls::VERSION; exit }
      parser.on("-al", "Show all files & folders, lengthwise") { option_all = true; option_long = true }
      parser.on("-h", "--help", "Show this help") { puts parser; exit }
    end

    path = args.first? || "."

    search_dir = Dir.new(path)

    file_names = search_dir.to_a

    longest_file = file_names.max_by { |file_name| file_name.size }.size
    column_width = longest_file + 10
    columns = width // column_width

    if !option_all
      file_names.reject! { |f| f.starts_with?(".") }
    end

    # TODO: Sort by different things
    file_names.sort_by! { |file|
      if File.directory?(File.join(path, file))
        "0#{file}"
      else
        "1#{file}"
      end
    }

    files = Array({filename: String, long_filename: String, size: UInt64, modification_time: String, owner: String, group: String, type: Symbol, absolute_path: String, extension: String, relative_path: String, real_path: String, permissions: File::Permissions}).new

    file_names.each do |file_or_dir|
      relative_path = File.join(path, file_or_dir)
      absolute_path = File.expand_path(relative_path)

      real_path = begin
        File.real_path(absolute_path)
      rescue
        File.readlink(absolute_path)
      end

      file_type = if File.directory?(absolute_path)
                    :directory
                  elsif File.executable?(absolute_path)
                    :executable
                  elsif File.symlink?(absolute_path)
                    :symlink
                  else
                    :file
                  end

      # File size won't be found for a symlinked file that has a missing origin file
      file_size = begin
        File.size(absolute_path)
      rescue
        0_u64
      end

      long_filename = if file_type == :symlink
                        "#{file_or_dir} ~> #{real_path}"
                      else
                        file_or_dir
                      end

      mtime = File.info(absolute_path, follow_symlinks: false).modification_time
      file_mtime = if Time.local.to_s("%Y") == mtime.to_s("%Y")
                     mtime.to_s("%b %e %H:%M")
                   else
                     mtime.to_s("%b %e  %Y")
                   end

      # TODO: Cache owner & group so we only look them up once
      owner = System::User.find_by(id: File.info(absolute_path, follow_symlinks: false).owner.to_s).to_s.gsub(/\([0-9]*\)$/, "")
      group = System::Group.find_by(id: File.info(absolute_path, follow_symlinks: false).group.to_s).to_s.gsub(/\([0-9]*\)$/, "")

      files << {
        filename:          file_or_dir,
        long_filename:     long_filename,
        size:              file_size,
        modification_time: file_mtime,
        owner:             owner,
        group:             group,
        type:              file_type,
        absolute_path:     absolute_path, # not used in styler
        extension:         File.extname(absolute_path),
        relative_path:     relative_path, # not used in styler
        real_path:         real_path,     # not used in styler
        permissions:       File.info(absolute_path, follow_symlinks: false).permissions,
      }
    end

    if option_long
      Colorls::Formatters::LongFormatter.call(files, column_width)
    else
      Colorls::Formatters::StandardFormatter.call(files, column_width, columns)
    end

    if option_report
      total_contents = files.size

      full_path = File.expand_path(path)

      total_files = files.count { |file| file[:type] == :file || file[:type] == :executable }
      total_folders = files.count { |file| file[:type] == :directory }

      puts "

      Found #{total_contents} contents in #{full_path}

            Files       : #{total_files}
            Folders     : #{total_folders}".colorize(:yellow)
    end
  end
  # ameba:enable Metrics/CyclomaticComplexity
end

Colorls.call(ARGV)
