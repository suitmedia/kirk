$:.unshift File.expand_path('../../build', __FILE__)
require 'kirk'
require 'fileutils'
require 'socket'
require 'zlib'
require 'popen4'
require 'rack/test'
require 'net/http'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |f| require f }

IP_ADDRESS = IPSocket.getaddress(Socket.gethostname)

RSpec.configure do |config|
  config.include SpecHelpers
  config.include Rack::Test::Methods

  config.before :each do
    reset!
  end

  config.after :each do
    @server.stop if @server
  end
end
