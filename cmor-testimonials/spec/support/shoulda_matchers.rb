require "shoulda-matchers"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
    with.library :active_model
  end
end
