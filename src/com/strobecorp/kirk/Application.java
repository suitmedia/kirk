package com.strobecorp.kirk;

import java.util.concurrent.atomic.AtomicReference;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.server.Request;

public class Application extends AbstractHandler {

  private String applicationPath;
  private String bootstrapPath;
  private AtomicReference<Deploy> currentDeploy;

  public Application(String applicationPath, String bootstrapPath) {
    super();

    this.applicationPath = applicationPath;
    this.bootstrapPath   = bootstrapPath;
    this.currentDeploy   = new AtomicReference<Deploy>(loadCurrentDeploy());

    spawnDeployWatcherThread();
  }

  public void handle(String target, Request baseRequest,
      HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    getCurrentDeploy().handle(target, baseRequest, request, response);
  }

  private Deploy getCurrentDeploy() {
    return currentDeploy.get();
  }

  private Deploy loadCurrentDeploy() {
    return new Deploy(applicationPath, bootstrapPath);
  }

  private void spawnDeployWatcherThread() {
    // Nothing yet
  }
}
