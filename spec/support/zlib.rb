module SpecHelpers
  def deflate(str)
    Zlib::Deflate.deflate(str)
  end

  def gzip(str)
    stream = StringIO.new
    gz = Zlib::GzipWriter.new(stream)
    gz.write(str)
    gz.close
    stream.string
  end
end
