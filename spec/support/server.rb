module SpecHelpers
  def kirkup(path)
    @server.stop if @server

    @server = Kirk::Server.build(path.to_s)
    @server.start
  end

  def start(app = nil, &blk)
    @server.stop if @server

    if app.respond_to?(:call)

      @server = Kirk::Server.start(app, :log_level => :warning)

    else

      blk ||= lambda do
        log :level => :warning

        rack app
      end

      @server = Kirk::Server.build(&blk)
      @server.start

    end
  end
end
