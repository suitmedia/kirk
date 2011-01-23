module SpecHelpers
  { 'be_successful' => 200,
    'be_missing'    => 404
  }.each do |method, status|
    RSpec::Matchers.define method do
      match do |response|
        response.status == status
      end
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
    'request_method' => 'REQUEST_METHOD',
    'body'           => 'rack.input'
  }.each do |k, v|
    RSpec::Matchers.define :"receive_#{k}" do |val|
      match do |response|
        env = Marshal.load(response.body)
        env[v] == val
      end
    end
  end
end
