module Kirk
  class Builder
    def initialize
      @current = nil
      @configs = []
    end

    def rack(path)
      @current = new_config
      @current.set_application_path path.to_s
      yield
    ensure
      @configs << @current
      @current = nil
    end

    def hosts(*hosts)
      @current.hosts.concat hosts
    end

    def listen(listen)
      listen = listen.to_s
      listen = ":#{listen}" unless listen.index(':')
      listen = "0.0.0.0#{listen}" if listen.index(':') == 0

      @current.listen = listen
    end

    def watch(watch)
      @current.watch = watch
    end

    def to_handler
      handlers = @configs.map do |c|
        Jetty::ContextHandler.new.tap do |ctx|
          ctx.set_connector_names [c.listen]
          ctx.set_handler Application.new(c)
        end
      end

      Jetty::ContextHandlerCollection.new.tap do |collection|
        collection.set_handlers(handlers)
      end
    end

    def to_connectors
      @configs.map do |c|
        Jetty::SelectChannelConnector.new.tap do |conn|
          host, port = c.listen.split(':')

          conn.set_host(host) unless host.empty?
          conn.set_port(port.to_i)
        end
      end
    end

  private

    def new_config
      ApplicationConfig.new.tap do |config|
        config.set_bootstrap_path File.expand_path('../bootstrap.rb', __FILE__)
        config.set_life_cycle_listener Application::WatcherThread.new
      end
    end
  end
end
