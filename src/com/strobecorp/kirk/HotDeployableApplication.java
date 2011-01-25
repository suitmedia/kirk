package com.strobecorp.kirk;

import java.util.concurrent.atomic.AtomicReference;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.server.Request;

public abstract class HotDeployableApplication extends AbstractHandler {

  private AtomicReference<Deploy> currentDeploy;
  private ApplicationConfig       config;

  public HotDeployableApplication(ApplicationConfig config) {
    super();

    this.config        = config;
    this.currentDeploy = new AtomicReference<Deploy>();
  }

  public void handle(String target, Request baseRequest,
      HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    getCurrentDeploy().handle(target, baseRequest, request, response);
  }

  public ApplicationConfig getConfig() {
    return config;
  }

  public void deploy(Deploy deploy) {
    Deploy previousDeploy = this.currentDeploy.getAndSet(deploy);

    if ( previousDeploy != null ) {
      previousDeploy.terminate();
    }
  }

  private Deploy buildDeploy() {
    return new Deploy(config);
  }

  private Deploy getCurrentDeploy() {
    return currentDeploy.get();
  }

}
