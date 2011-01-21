module SpecHelpers
  def start(*args)
    @server.stop if @server
    @server = Kirk.start(*args)
  end
end
