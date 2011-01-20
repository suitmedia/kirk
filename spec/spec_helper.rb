$:.unshift File.expand_path('../../build', __FILE__)
require 'kirk'
require 'fileutils'
require 'rack/test'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include SpecHelpers
  config.include Rack::Test::Methods

  config.before :each do
    reset!
  end
end
