module Kirk
  require 'java'
  require 'kirk/native'
  require 'kirk/jetty'
  require 'kirk/version'

  import "com.strobecorp.kirk.Application"
  import "com.strobecorp.kirk.ApplicationConfig"

  require 'kirk/application'
  require 'kirk/application_config'
  require 'kirk/builder'
  require 'kirk/server'
end
