run lambda { |e|
  body = ""

  require 'active_support'
  body << "required ActiveSupport\n"

  begin
    require 'rake'
    body << "successfully loaded Rake\n"
  rescue LoadError
    body << "failed to load Rake\n"
  end

  [ 200, { 'Content-Type' => 'text/plain' }, [ body ] ]
}
