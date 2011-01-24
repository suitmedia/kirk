module Kirk
  class Builder

    VALID_LOG_LEVELS = %w(severe warning info config fine finer finest all)

    attr_reader :options

    def initialize
      @current = nil
      @configs = []
      @options = {}
    end

    def log(opts = {})
      level = opts[:level]
      raise "Invalid log level" unless VALID_LOG_LEVELS.include?(level.to_s)
      @options[:log_level] = level.to_s
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
          # Set the virtual hosts
          unless c.hosts.empty?
            ctx.set_virtual_hosts(c.hosts)
          end

          ctx.set_connector_names [c.listen]
          ctx.set_handler Application.new(c)
        end
      end

      Jetty::ContextHandlerCollection.new.tap do |collection|
        collection.set_handlers(handlers)
      end
    end

    def to_connectors
      @connectors = {}

      @configs.each do |config|
        next if @connectors.key?(config.listen)

        host, port = config.listen.split(':')

        connector = Jetty::SelectChannelConnector.new
        connector.set_host(host)
        connector.set_port(port.to_i)

        @connectors[config.listen] = connector
      end

      @connectors.values
    end

  private

    def new_config
      ApplicationConfig.new.tap do |config|
        config.listen = '0.0.0.0:9090'
        config.set_bootstrap_path File.expand_path('../bootstrap.rb', __FILE__)
        config.set_life_cycle_listener Application::WatcherThread.new
      end
    end
  end
end
