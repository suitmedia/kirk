module Kirk
  module Applications
    class Config
      include Native::ApplicationConfig

      attr_accessor :hosts,
                    :listen,
                    :watch,
                    :application_path,
                    :bootstrap_path

      def initialize
        @hosts  = []
        @listen = listen
      end

      # Handle the java interface
      alias getApplicationPath    application_path
      alias getBootstrapPath      bootstrap_path
    end
  end
end
