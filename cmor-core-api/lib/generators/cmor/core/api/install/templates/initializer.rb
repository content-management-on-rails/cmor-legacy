Rails.application.config.to_prepare do
  Cmor::Core::Api.configure do |config|
    # Add engines with apis by registering them here.
    #
    # Example:
    #
    #     config.register_engine("Blog::Api::Engine", {})
    #

    # Configure default url options for the url helpers used in the api.
    #
    # Example:
    #
    #     config.default_url_options = { host: "http://localhost:3000" }
    #
    # Default:
    #
    #     config.default_url_options = -> { Rails.application.routes.default_url_options }
    #
    config.default_url_options = -> { Rails.application.routes.default_url_options }
  end
end
