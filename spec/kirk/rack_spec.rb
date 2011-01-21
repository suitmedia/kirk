require 'spec_helper'

describe "Kirk's Rack handler" do
  it "passes the correct rack env to the rack app" do
    start echo_app_path

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
      'SERVER_NAME'       => '127.0.0.1',
      'REMOTE_HOST'       => '127.0.0.1',
      'REMOTE_ADDR'       => '127.0.0.1',
      'REMOTE_USER'       => '',
      'SERVER_PORT'       => '8080',

      'CONTENT_LENGTH'    => "0",
      'HTTP_ACCEPT'       => "*/*",

      'HTTP_CONNECTION'   => 'close',
      'HTTP_HOST'         => '127.0.0.1:8080',

      'rack.input'        => nil
    )
  end
end
