require "kirk/jetty/jetty-server-7.2.2.v20101205"
require "kirk/jetty/servlet-api-2.5"

module Kirk
  module Jetty
    # Gimme Jetty
    import "org.eclipse.jetty.server.nio.SelectChannelConnector"
    import "org.eclipse.jetty.server.handler.AbstractHandler"
    import "org.eclipse.jetty.server.Server"
  end
end
