module Kirk
  require 'java'
  require 'kirk/native'
  require 'kirk/jetty'
  require 'kirk/version'

  import "com.strobecorp.kirk.Application"
  import "com.strobecorp.kirk.ApplicationConfig"

  require 'kirk/application'
  require 'kirk/server'

  def self.start(path, opts = {})
    Server.new(Application.build(path, opts)).tap do |server|
      server.start
    end
  end
end
