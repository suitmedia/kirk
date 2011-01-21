module Kirk
  class Server
    def self.build(&blk)
      builder = Builder.new
      builder.instance_eval(&blk)
      new(builder.to_handler, builder.to_connectors)
    end

    def initialize(handler, connectors)
      @handler, @connectors = handler, connectors
    end

    def start
      @server = Jetty::Server.new.tap do |server|
        @connectors.each do |conn|
          server.add_connector(conn)
          server.set_handler(@handler)
        end
      end

      @server.start
    end

    def join
      @server.join
    end

    def stop
      @server.stop
    end
  end
end
