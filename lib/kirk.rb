module Kirk
  require 'java'

  require 'kirk/native'
  require 'kirk/jetty'
  require 'kirk/version'

  import "java.util.logging.Logger"
  import "java.util.logging.Level"
  import "java.util.logging.ConsoleHandler"

  module Native
    import "com.strobecorp.kirk.ApplicationConfig"
    import "com.strobecorp.kirk.HotDeployableApplication"
    import "com.strobecorp.kirk.LogFormatter"
  end

  module Applications
    autoload :Config,         'kirk/applications/config'
    autoload :HotDeployable,  'kirk/applications/hot_deployable'
    autoload :Rack,           'kirk/applications/rack'
  end

  require 'kirk/builder'
  require 'kirk/handler'
  require 'kirk/input_stream'
  require 'kirk/server'

  # Configure the logger
  def self.logger
    @logger ||= begin
      logger = Logger.get_logger("org.eclipse.jetty.util.log")
      logger.set_use_parent_handlers(false)
      logger.add_handler logger_handler
      logger
    end
  end

  def self.logger_handler
    ConsoleHandler.new.tap do |handler|
      handler.set_output_stream(java::lang::System.out)
      handler.set_formatter(Native::LogFormatter.new)
    end
  end
end
