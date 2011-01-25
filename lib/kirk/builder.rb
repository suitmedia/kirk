module Kirk
  class MissingConfigFile < RuntimeError ; end

  class Builder

    VALID_LOG_LEVELS = %w(severe warning info config fine finer finest all)

    attr_reader :options

    def initialize(root = nil)
      @root    = root || Dir.pwd
      @current = nil
      @configs = []
      @options = {}
    end

    def load(path)
      path = File.expand_path(path, @root)

      with_root File.dirname(path) do
        unless File.exist?(path)
          raise MissingConfigFile, "config file `#{path}` does not exist"
        end

        instance_eval(File.read(path), path)
      end
    end

    def log(opts = {})
      level = opts[:level]
      raise "Invalid log level" unless VALID_LOG_LEVELS.include?(level.to_s)
      @options[:log_level] = level.to_s
    end

    def rack(path)
      @current = new_config
      @current.application_path = path.to_s

      yield if block_given?

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
          ctx.set_handler Applications::HotDeployable.new(c)
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

    def with_root(root)
      old, @root = @root, root
      yield
    ensure
      @root = old
    end

    def new_config
      Applications::Config.new.tap do |config|
        config.listen         = '0.0.0.0:9090'
        config.bootstrap_path = File.expand_path('../bootstrap.rb', __FILE__)
      end
    end
  end
end
