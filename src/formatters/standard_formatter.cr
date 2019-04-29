module StandardFormatter
  def self.call(files : Array, column_width : Int32, columns : Int32)
    files.each_slice(columns) do |batch|
      batch.each do |file|
        print "    %s %-#{column_width}s" % [Styler.icon(file), Styler.filename(file)]
      end

      print "\n"
    end
  end
end
