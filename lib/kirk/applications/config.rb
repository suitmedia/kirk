module Kirk
  module Applications
    class Config
      include Native::ApplicationConfig

      attr_accessor :hosts,
                    :listen,
                    :watch,
                    :rackup,
                    :application_path,
                    :bootstrap_path

      def initialize
        @hosts  = []
        @listen = listen
      end

      def application_path
        @application_path || File.dirname(rackup)
      end

      # Handle the java interface
      alias getApplicationPath    application_path
      alias getRackupPath         rackup
      alias getBootstrapPath      bootstrap_path
    end
  end
end
