module Kirk
  class Bootstrap
    def run(application_path)
      Dir.chdir File.expand_path(application_path)

      # Load the Gemfile
      require "rubygems"
      require "bundler/setup"

      $:.unshift File.expand_path('../..', __FILE__)

      require "rack"
      require "kirk/version"
      require "kirk/input_stream"
      require "kirk/handler"

      Kirk::Handler.new
    end
  end
end

Kirk::Bootstrap.new
