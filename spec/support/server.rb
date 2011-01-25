module SpecHelpers
  def start(app = nil, &blk)
    @server.stop if @server

    if app.respond_to?(:call)

      @server = Kirk::Server.start(app, :log_level => :warning)

    else

      blk ||= lambda do
        log :level => :warning

        rack app do
          listen  "0.0.0.0:9090"
          watch   "REVISION"
        end
      end

      @server = Kirk::Server.build(&blk)
      @server.start

    end
  end
end
