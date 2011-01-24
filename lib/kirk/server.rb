module Kirk
  class Server
    def self.build(file = nil, &blk)
      builder = Builder.new

      file ? builder.instance_eval(File.read(file), file) :
             builder.instance_eval(&blk)

      new(builder.to_handler, builder.to_connectors, builder.options)
    end

    def initialize(handler, connectors, options)
      @handler, @connectors, @options = handler, connectors, options
    end

    def start
      @server = Jetty::Server.new.tap do |server|
        @connectors.each do |conn|
          server.add_connector(conn)
          server.set_handler(@handler)
        end
      end

      configure!

      @server.start
    end

    def join
      @server.join
    end

    def stop
      @server.stop
    end

  private

    def configure!
      Kirk.logger.set_level log_level
    end

    %w(severe warning info config fine finer finest all)

    def log_level
      case @options[:log_level] || "info"
      when "severe"   then Level::SEVERE
      when "warning"  then Level::WARNING
      when "info"     then Level::INFO
      when "config"   then Level::CONFIG
      when "fine"     then Level::FINE
      when "finer"    then Level::FINER
      when "finest"   then Level::FINEST
      when "all"      then Level::ALL
      end
    end
  end
end
