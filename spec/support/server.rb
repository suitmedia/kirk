module SpecHelpers
  def start(path)
    @server.stop if @server
    @server = Kirk::Server.build do
      rack path do
        listen  "0.0.0.0:9090"
        watch   'REVISION'
      end
    end
    @server.start
  end
end
