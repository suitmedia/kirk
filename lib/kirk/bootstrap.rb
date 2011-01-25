require 'java'

module Kirk
  import 'java.util.zip.GZIPInputStream'
  import 'java.util.zip.InflaterInputStream'

  class Bootstrap
    def run(application_path, rackup)
      Dir.chdir File.expand_path(application_path)

      load_rubygems
      load_bundle

      add_kirk_to_load_path

      load_rack
      load_kirk

      app, options = Rack::Builder.parse_file(rackup)

      Kirk::Handler.new(app)
    end

  private

    def load_rubygems
      require 'rubygems'
    end

    def load_bundle
      require 'bundler/setup' if File.exist?('Gemfile')
    end

    def add_kirk_to_load_path
      $:.unshift File.expand_path('../..', __FILE__)
    end

    def load_rack
      gem "rack", ">= 1.0.0"
      require 'rack'
    end

    def load_kirk
      require 'kirk/version'
      require 'kirk/input_stream'
      require 'kirk/handler'
    end
  end
end

Kirk::Bootstrap.new
