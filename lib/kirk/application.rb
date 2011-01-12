module Kirk
  class Application < Jetty::AbstractHandler

    import "java.util.concurrent.atomic.AtomicReference"

    def self.new(path, options = {})
      inst = super()
      inst.setup(path, options)
      inst
    end

    attr_reader :path

    def setup(path, options)
      @path, @options  = File.expand_path(path), options
      @current_deploy  = AtomicReference.new load_current_deploy

      spawn_deploy_watcher_thread
    end

    def handle(target, base_request, request, response)
      current_deploy.handle(target, base_request, request, response)
    end

  private

    def current_deploy
      @current_deploy.get
    end

    def load_current_deploy
      Deploy.new(self)
    end

    def spawn_deploy_watcher_thread
      # do magic
    end
  end
end
