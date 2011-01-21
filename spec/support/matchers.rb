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
end
