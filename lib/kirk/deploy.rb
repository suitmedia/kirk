require 'rack'
module Kirk
  class Deploy
    def initialize(app)
      @app = app
      @context, @handler = spawn_context
    end

    def handle(target, base_request, request, response)
      @handler.handle(target, base_request, request, response)
    end

    def terminate
      @context.terminate
    end

  private

    def spawn_context
      context = ScriptingContainer.new(LocalContextScope::THREADSAFE)
      handler = context.run_scriptlet(bootstrap_script)

      [ context, handler ]
    end

    def bootstrap_script
      <<-RUBY
        # Change into the directory
        Dir.chdir "#{application_path}"

        # Load the Gemfile
        require "rubygems"
        require "bundler/setup"

        # Load the Kirk handler
        $:.unshift "#{runtime_path}"
        require "kirk/handler"

        Kirk::Handler.new
      RUBY
    end

    def runtime_path
      File.dirname(File.dirname(__FILE__))
    end

    def application_path
      @app.path
    end
  end
end
