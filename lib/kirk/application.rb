module Kirk
  class Application < Jetty::AbstractHandler

    import "java.util.concurrent.atomic.AtomicReference"

    def self.new(app, options = {})
      inst = super()
      inst.setup(app, options)
      inst
    end

    attr_reader :path

    def setup(app, options)
      @app, @options  = app, options
      @current_deploy = AtomicReference.new load_current_deploy

      spawn_deploy_watcher_thread
    end

    def handle(target, request, response, dispatch)
      current_deploy.handle(target, request, response, dispatch)
    end

  private

    def current_deploy
      @current_deploy.get
    end

    def load_current_deploy
      Deploy.new
    end

    def spawn_deploy_watcher_thread
      # do magic
    end
  end
end
