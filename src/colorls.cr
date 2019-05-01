require "option_parser"
require "colorize"
require "termbox"
require "./styler"
require "./formatters/standard_formatter"
require "./formatters/long_formatter"

include Termbox

module Colorls
  VERSION = "0.1.1"
end

w = Window.new
width = w.width

option_all = false
option_long = false
option_report = false
option_sort = "name"

OptionParser.parse! do |parser|
  parser.banner = "Usage: colorls [arguments]"
  parser.on("-l", "--long", "Length-wise") { option_long = true }
  parser.on("-a", "--all", "Show all files & folders") { option_all = true }
  parser.on("-v", "--version", "Print version") { puts Colorls::VERSION; exit }
  parser.on("-r", "--report", "Print summary") { option_report = true }
  parser.on("-al", "Show all files & folders, lengthwise") { option_all = true; option_long = true }
  parser.on("-h", "--help", "Show this help") { puts parser; exit }
end

path = ARGV.first? || "."

files_and_folders = Array(String).new

search_dir = Dir.new(path)

file_names = search_dir.to_a

longest_file = file_names.max_by { |file_name| file_name.size }.size
column_width = longest_file + 10
columns = width / column_width

if !option_all
  file_names.reject! { |f| f.starts_with?(".") }
end

# TODO: Sort by different things
file_names.sort_by! { |file|
  if File.info(File.join(path, file)).directory?
    "0#{file}"
  else
    "1#{file}"
  end
}

files = Array({filename: String, size: UInt64, modification_time: Time, owner: UInt32, group: UInt32, type: Symbol, absolute_path: String, extension: String, relative_path: String, permissions: File::Permissions}).new

file_names.each do |file_or_dir|
  relative_path = File.join(path, file_or_dir)
  absolute_path = File.expand_path(relative_path)

  file_type = if File.directory?(relative_path)
                :directory
              elsif File.executable?(relative_path)
                :executable
              else
                :file
              end

  files << {
    filename:          file_or_dir,
    size:              File.info(relative_path).size,
    modification_time: File.info(relative_path).modification_time,
    owner:             File.info(relative_path).owner,
    group:             File.info(relative_path).group,
    type:              file_type,
    absolute_path:     absolute_path,
    extension:         File.extname(relative_path),
    relative_path:     relative_path,
    permissions:       File.info(relative_path).permissions,
  }
end

if option_long
  LongFormatter.call(files, column_width)
else
  StandardFormatter.call(files, column_width, columns)
end

if option_report
  total_contents = files.size

  full_path = File.expand_path(path)

  total_files = files.select { |file| file[:type] == :file || file[:type] == :executable }.size
  total_folders = files.select { |file| file[:type] == :directory }.size

  puts "

  Found #{total_contents} contents in #{full_path}

        Files       : #{total_files}
        Folders     : #{total_folders}".colorize(:yellow)
end
