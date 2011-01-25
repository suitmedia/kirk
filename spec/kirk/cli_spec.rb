require 'spec_helper'

describe "Kirk CLI interface" do
  it "reads the configuration file" do
    kirk "-c #{kirked_up_path}/Kirkfile" do
      stdout.gets.should =~ /INFO - jetty/
      stdout.gets.should =~ /INFO - Started SelectChannelConnector@0\.0\.0\.0:9090/

      get '/'
      last_response.should be_successful
      last_response.should have_body('Hello World')
    end
  end

  it "exits with an error if the config file does not exist" do
    kirk do
      stderr.read.chomp.should == "[ERROR] config file `/Users/carllerche/Developer/Source/kirk/Kirkfile` does not exist"
    end

    exit_status.should == 1
  end
end
