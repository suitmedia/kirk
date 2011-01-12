module SpecHelpers
  RSpec::Matchers.define :be_successful do
    match do |response|
      response.status == 200
    end
  end

  RSpec::Matchers.define :have_body do |expected|
    match do |response|
      response.body.should == expected
    end
  end
end
