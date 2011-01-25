package com.strobecorp.kirk;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import org.eclipse.jetty.server.Request;
import org.jruby.embed.PathType;
import org.jruby.embed.LocalContextScope;
import org.jruby.embed.ScriptingContainer;
import org.jruby.runtime.builtin.IRubyObject;

public class Deploy {

  private ScriptingContainer context;
  private Object             handler;

  public Deploy(ApplicationConfig config) {
    ScriptingContainer context = new ScriptingContainer(LocalContextScope.THREADSAFE);
    Object bootstrapper = context.runScriptlet(PathType.ABSOLUTE, config.getBootstrapPath());

    this.context = context;
    this.handler = context.callMethod(bootstrapper, "run",
      config.getApplicationPath(), config.getRackupPath());
  }

  public void handle(String target, Request baseRequest,
      HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    context.callMethod(handler, "handle", target, baseRequest, request, response);
  }

  public void terminate() {
    this.context.terminate();
    this.context = null;
    this.handler = null;
  }

}
