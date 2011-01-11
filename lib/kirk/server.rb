module Kirk
  class Server
    def initialize(app)
      @app = app
    end

    def run(host, port = 8080)
      connector = Jetty::SelectChannelConnector.new
      connector.set_host(host)
      connector.set_port(port)

      server = Jetty::Server.new
      server.add_connector(connector)
      server.set_handler(@app)

      server.start
      server.join
    end
  end
end
