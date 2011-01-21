module Kirk
  class ApplicationConfig
    attr_accessor :hosts, :listen, :watch

    def initialize
      @hosts  = []
      @listen = listen
    end
  end
end
