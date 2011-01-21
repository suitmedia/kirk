module SpecHelpers
  RSpec::Matchers.define :be_successful do
    match do |response|
      response.status == 200
    end
  end

  RSpec::Matchers.define :have_body do |expected|
    match do |response|
      response.body == expected
    end
  end

  RSpec::Matchers.define :have_env do |expected|
    env = nil

    match do |response|
      env = Marshal.load(response.body)
      env == expected
    end

    failure_message do
      "Expected Rack env:\n#{expected.inspect}\n  Got instead:\n#{env.inspect}"
    end
  end

  {

    'request_method' => 'REQUEST_METHOD'

  }.each do |k, v|
    RSpec::Matchers.define :"have_#{k}" do |val|
      match do |response|
        env = Marshal.load(response.body)
        env[v] == val
      end
    end
  end
end
