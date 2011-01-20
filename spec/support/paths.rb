module SpecHelpers
  include FileUtils

  def reset!
    rm_rf   tmp
    mkdir_p tmp
    cp_r    spec('support/applications'), tmp
  end

  def root
    @root ||= Pathname.new(File.expand_path("../../..", __FILE__))
  end

  def spec(*args)
    root.join('spec', *args)
  end

  def application_path(*args)
    tmp('applications', *args)
  end

  def hello_world_path(*args)
    application_path('hello_world', *args)
  end

  def randomized_app_path(*args)
    application_path('randomized', *args)
  end

  def tmp(*args)
    root.join('tmp', *args)
  end
end
