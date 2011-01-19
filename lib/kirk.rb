module Kirk
  require 'java'
  require 'kirk/native'
  require 'kirk/jetty'
  require 'kirk/server'

  import "com.strobecorp.kirk.Application"
  import "com.strobecorp.kirk.ApplicationConfig"

  def self.start(path, opts = {})
    application = Application.new(build_config(path, opts))

    Server.new(application).tap do |server|
      server.start
    end
  end

  def self.build_config(path, opts = {})
    config = ApplicationConfig.new
    config.set_application_path path.to_s
    config.set_bootstrap_path File.expand_path('../kirk/bootstrap.rb', __FILE__)
    config.set_reload_each_request true
    config
  end
end
