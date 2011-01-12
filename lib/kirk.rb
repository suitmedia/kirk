module Kirk
  require 'java'
  require 'kirk/jetty'
  require 'kirk/application'
  require 'kirk/deploy'
  require 'kirk/server'

  # JRuby stuff
  import "org.jruby.embed.LocalContextScope"
  import "org.jruby.embed.ScriptingContainer"

  def self.start(path, options = {})
    application = Application.new(path)
    server      = Server.new(application)

    server.run('127.0.0.1')
  end
end
