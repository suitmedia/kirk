package com.strobecorp.kirk;

import org.eclipse.jetty.util.component.LifeCycle;

public class ApplicationConfig {

  private String              applicationPath;
  private String              bootstrapPath;
  private LifeCycle.Listener  lifeCycleListener;

  public String getApplicationPath() {
    return applicationPath;
  }

  public void setApplicationPath(String applicationPath) {
    this.applicationPath = applicationPath;
  }

  public String getBootstrapPath() {
    return bootstrapPath;
  }

  public void setBootstrapPath(String bootstrapPath) {
    this.bootstrapPath = bootstrapPath;
  }

  public LifeCycle.Listener getLifeCycleListener() {
    return lifeCycleListener;
  }

  public void setLifeCycleListener(LifeCycle.Listener lifeCycleListener) {
    this.lifeCycleListener = lifeCycleListener;
  }

}
