require 'spec_helper'

describe "Kirk's Rack handler" do
  before :each do
    start echo_app_path
  end

  it "passes the correct rack env to the rack app" do
    get '/'

    last_response.should have_env(
      # Default env
      'SERVER_SOFTWARE'   => 'kirk 0.0.1',
      'rack.version'      => Rack::VERSION,
      'rack.errors'       => true,
      'rack.multithread'  => true,
      'rack.multiprocess' => false,
      'rack.run_once'     => false,

      # Request specific
      'REQUEST_URI'       => '/',
      'PATH_INFO'         => '/',
      'REQUEST_METHOD'    => 'GET',
      'QUERY_STRING'      => '',
      'SERVER_NAME'       => 'example.org',
      'REMOTE_HOST'       => '127.0.0.1',
      'REMOTE_ADDR'       => '127.0.0.1',
      'REMOTE_USER'       => '',
      'SERVER_PORT'       => '80',

      'CONTENT_LENGTH'    => "0",
      'HTTP_HOST'         => "example.org",
      'HTTP_ACCEPT'       => "*/*",
      'HTTP_CONNECTION'   => 'close',

      'rack.input'        => nil
    )
  end

  it "passes the correct REQUEST_METHOD" do
    post '/'

    last_response.should receive_request_method('POST')
  end

  it "provides the request body" do
    post '/', {}, :input => "ZOMG"

    last_response.should receive_body('ZOMG')
  end

  it "inflates a deflated body" do
    post '/', {}, :input => Zlib::Deflate.deflate('Hello world'),
                  'HTTP_CONTENT_ENCODING' => 'deflate'

    last_response.should receive_body('Hello world')
  end
end
