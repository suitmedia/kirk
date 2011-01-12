module Kirk
  require 'java'
  require 'kirk/native'
  require 'kirk/jetty'
  require 'kirk/server'

  import "com.strobecorp.kirk.Application"

  def self.start(path, options = {})
    application = Application.new(path.to_s, File.expand_path('../kirk/bootstrap.rb', __FILE__))

    Server.new(application).tap do |server|
      server.start
    end
  end
end
