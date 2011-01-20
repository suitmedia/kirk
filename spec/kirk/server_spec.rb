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

  it "reloads the server" do
    @server = Kirk.start randomized_app_path

    get '/'
    num = last_response.body

    get '/'
    last_response.body.should == num

    touch randomized_app_path('REVISION')
    # Gives the server the time to see the
    # revision change and reload the app
    sleep 2

    get '/'
    last_response.body.should_not == num
  end
end
