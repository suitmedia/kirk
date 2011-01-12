module SpecHelpers
  def root
    @root ||= Pathname.new(File.expand_path("../../..", __FILE__))
  end

  def application_path(*args)
    root.join('spec/support/applications', *args)
  end

  def hello_world_path(*args)
    application_path('hello_world', *args)
  end
end
