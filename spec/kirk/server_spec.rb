require 'spec_helper'
require 'net/http'

describe 'Kirk::Server' do
  after :each do
    @server.stop
  end

  it "runs the server" do
    @server = Kirk.start hello_world_path

    get '/'
    last_response.should be_successful
    last_response.should have_body('Hello World')
  end
end
