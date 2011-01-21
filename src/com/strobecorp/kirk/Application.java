package com.strobecorp.kirk;

import java.util.concurrent.atomic.AtomicReference;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.server.Request;

public class Application extends AbstractHandler {

  private AtomicReference<Deploy> currentDeploy;
  private ApplicationConfig       config;

  public Application(ApplicationConfig config) {
    super();

    this.config        = config;
    this.currentDeploy = new AtomicReference<Deploy>();

    if ( this.config.getLifeCycleListener() != null ) {
      addLifeCycleListener( this.config.getLifeCycleListener() );
    }

    reloadDeploy();
  }

  public void handle(String target, Request baseRequest,
      HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    getCurrentDeploy().handle(target, baseRequest, request, response);
  }

  public ApplicationConfig getConfig() {
    return config;
  }

  public void reloadDeploy() {
    this.currentDeploy.set(loadCurrentDeploy());
  }

  private Deploy getCurrentDeploy() {
    return currentDeploy.get();
  }

  private Deploy loadCurrentDeploy() {
    return new Deploy(config.getApplicationPath(), config.getBootstrapPath());
  }
}
