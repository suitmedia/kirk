package com.strobecorp.kirk;

import org.eclipse.jetty.util.component.LifeCycle;

public interface ApplicationConfig {

  public String             getApplicationPath();
  public String             getBootstrapPath();
  public LifeCycle.Listener getLifeCycleListener();

}
