module Kirk
  class ApplicationConfig
    include Native::ApplicationConfig

    attr_accessor :hosts,
                  :listen,
                  :watch,
                  :application_path,
                  :bootstrap_path,
                  :lifecycle_listener

    def initialize
      @hosts  = []
      @listen = listen
    end

    # Handle the java interface
    alias getApplicationPath    application_path
    alias getBootstrapPath      bootstrap_path
    alias getLifeCycleListener  lifecycle_listener
  end
end
