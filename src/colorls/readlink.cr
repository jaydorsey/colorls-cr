# https://github.com/crystal-lang/crystal/issues/3284
# https://stackoverflow.com/q/50959527/2892779
lib LibC
  fun readlink(pathname : Char*, buf : Char*, bufsiz : SizeT) : SizeT
end

def File.readlink(path)
  buf = uninitialized UInt8[1024]
  size = LibC.readlink(path.to_unsafe, buf.to_unsafe, 1024).to_i32

  if size == -1
    raise Errno.new("readlink")
  elsif size > 1024
    raise "buffer too small"
  else
    String.new(buf.to_unsafe, size)
  end
end
