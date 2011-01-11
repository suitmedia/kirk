require 'spec_helper'
require 'openssl'

describe 'Kirk::InputStream' do

  CHUNK_SIZE    =   4 * 1_024
  GIBBERISH_LEN = 256 * 1_024
  GIBBERISH     = OpenSSL::Random.random_bytes(GIBBERISH_LEN)

  def with_input_stream
    r, w  = IO.pipe
    input = Kirk::InputStream.new(r.to_inputstream)
    yield input, w
    w.close unless w.closed?
    input
  end

  def each_chunk(str)
    pos = 0
    until pos >= str.length
      yield str[pos, CHUNK_SIZE]
      pos += CHUNK_SIZE
    end
    str
  end

  def stream(io, str)
    each_chunk(str) { |chunk| io << chunk }
  end

  it "reads a short, single chunk stream" do
    with_input_stream do |input, writer|
      writer << "zomgzomg"
      writer.close
      input.read.should == "zomgzomg"
    end
  end

  it "reads a short, multi chunk stream" do
    with_input_stream do |input, writer|
      writer << "zomg" << "zomg"
      writer.close
      input.read.should == "zomgzomg"
    end
  end

  it "can specify the chunk size to read" do
    with_input_stream do |input, writer|
      writer << "zomgzomg"
      writer.close

      input.read(4).should == "zomg"
      input.read(4).should == "zomg"
      input.read(4).should be_nil
    end
  end

  it "raises if trying to seek to a negative value" do
    with_input_stream do |input, writer|
      writer << "zomgzomg"
      writer.close

      lambda { input.seek(-1) }.should raise_error(Errno::EINVAL)
    end
  end

  it "can rewind to the start of the chunk" do
    with_input_stream do |input, writer|
      writer << "zomgzomg"
      writer.close

      input.read.should == "zomgzomg"
      input.rewind
      input.read.should == "zomgzomg"
      input.read.should be_nil
    end
  end

  it "can seek ahead of what is currently read" do
    with_input_stream do |input, writer|
      writer << "zomgzomg"
      writer.close

      input.seek(6)
      input.read.should == "mg"
      input.rewind
      input.read.should == "zomgzomg"
    end
  end

  it "reads large streams in one call" do
    with_input_stream do |input, writer|
      Thread.new do
        stream writer, GIBBERISH
        writer.close
      end

      input.read.should == GIBBERISH
    end
  end
end
