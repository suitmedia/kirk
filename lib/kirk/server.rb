module Kirk
  class Server
    def initialize(app)
      @app    = app
      @server = nil
    end

    def start(host = '127.0.0.1', port = 8080)
      @server = build_server(build_connector(host, port))
      @server.start
    end

    def join
      @server.join
    end

    def stop
      @server.stop
    end

  private

    def build_connector(host, port)
      Jetty::SelectChannelConnector.new.tap do |conn|
        conn.set_host(host)
        conn.set_port(port)
      end
    end

    def build_server(connector)
      Jetty::Server.new.tap do |server|
        server.add_connector(connector)
        server.set_handler(@app)
      end
    end
  end
end
