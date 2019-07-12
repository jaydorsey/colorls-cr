module Colorls
  module Formatters
    module LongFormatter
      def self.call(files : Array, column_width : Int32)
        longest_size = files.max_by { |file| file[:size] }[:size].to_s.size

        files.each do |file|
          puts "  %s % #{longest_size}s   %s  %s  %-#{column_width}s" % [
            file[:permissions].to_s[0..9],
            file[:size].humanize_bytes(precision: 2),
            file[:modification_time],
            Styler.icon(file),
            Styler.long_filename(file),
          ]
        end
      end
    end
  end
end
