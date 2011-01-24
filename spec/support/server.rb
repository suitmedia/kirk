module SpecHelpers
  def start(path = nil, &blk)
    @server.stop if @server

    blk ||= lambda do
      log :level => :warning

      rack path do
        listen  "0.0.0.0:9090"
        watch   "REVISION"
      end
    end

    @server = Kirk::Server.build(&blk)
    @server.start
  end
end
