require "authlogic/test_case"

RSpec.configure do |config|
  config.before(:all) do
    include Authlogic::TestCase
    # activate_authlogic
  end
end
