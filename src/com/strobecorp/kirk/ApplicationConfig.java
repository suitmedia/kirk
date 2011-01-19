package com.strobecorp.kirk;

public class ApplicationConfig {

  private String  applicationPath;
  private String  bootstrapPath;
  private Boolean reloadEachRequest;

  public ApplicationConfig() {
    this.reloadEachRequest = false;
  }

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

  public Boolean getReloadEachRequest() {
    return reloadEachRequest;
  }

  public void setReloadEachRequest(Boolean reloadEachRequest) {
    this.reloadEachRequest = reloadEachRequest;
  }

}
