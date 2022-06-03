Rails.application.config.to_prepare do
  Cmor::Core::Api.configure do |config|
    # Add engines with apis by registering them here.
    #
    # Example:
    #
    #     config.register_engine("Blog::Api::Engine", {})
    #
  end
end
