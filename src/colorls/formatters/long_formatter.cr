module Colorls
  module Formatters
    module LongFormatter
      def self.call(files : Array, column_width : Int32)
        longest_owner = files.max_by { |file| file[:owner] }[:size].to_s.size
        longest_group = files.max_by { |file| file[:group] }[:size].to_s.size
        longest_size = files.max_by { |file| file[:size] }[:size].to_s.size

        files.each do |file|
          puts " %s %-#{longest_owner}s %-#{longest_group}s %-#{longest_size}s %s %s %-#{column_width}s" % [
            file[:permissions].to_s[0..9],
            file[:owner],
            file[:group],
            file[:size].humanize_bytes(precision: 2, format: :JEDEC),
            file[:modification_time],
            Styler.icon(file),
            Styler.long_filename(file),
          ]
        end
      end
    end
  end
end
