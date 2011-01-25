# Kirk: a JRuby Rack server based on Jetty

Kirk is a wrapper around Jetty that hides all of the insanity and wraps your
Rack application in a loving embrace. Also, Kirk is probably the least HTTP
retarded ruby rack server out there.

### Features

Here is a brief highlight of some of the features available.

* 0 Downtime deploys: Deploy new versions of your rack application without
  losing a single request. The basic strategy is similar to Passenger.
  Basically, touch a magic file in the application root and Kirk will reload the
  application without dropping a single request... It's just magic.

* Request body streaming: Have a large request body to handle? Why wait until
  receiving the entire thing before starting the work?

* HTTP goodness: `Transfer-Encoding: chunked`, `Content-Encoding: gzip` (and
  deflate) support on the request.

* Concurrency: As it turns out, it's nice to not block your entire application
  while waiting for an HTTP request to finish. It's also nice to be able to
  handle more than 50 concurrent requests without burning over 5GB of RAM. Sure,
  RAM is cheap, but using Kirk is cheaper ;)

* Run on the JVM: I, for one, am a fan of having a predictable GC, a JIT
  compiler, and other goodness.

### Getting Started

The TL;DR way:

    gem install kirk
    rackup -s Kirk config.ru

### Caveats

This is still a pretty new project and a lot of settings that should be
abstracted are still hardcoded in the source.

* Kirk requires JRuby 1.6.0 RC 1 or greater. This is due to a JRuby bug that
  was fixed in the 1.6 branch but never backported to older versions of JRuby.
  Crazy stuff happens without the bug fix.

* There is a memory leak if you are reloading an application that uses any of
  the JDBC gems. This should be fixed on JRuby master but not the JRuby 1.6.0
  RC 1 release.

### Getting Help

Ping me (carllerche) on Freenode in #carlhuda
