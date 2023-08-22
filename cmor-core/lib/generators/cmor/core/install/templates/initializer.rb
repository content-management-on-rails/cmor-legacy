Cmor::Core.configure do |config|
  # Set the default markup options to be used in cmor modules.
  #
  # Default: config.default_markup_options = { processor: :markdown }
  #
  config.default_markup_options = { processor: :markdown }

  # Enables the Cmor::Comments integration
  #
  # config.enable_feature :cmor_comments, {}

  # Enables the Cmor::Tags integration
  #
  # config.enable_feature :cmor_tags, {}

  # Enables the Cmor::Seo integration
  #
  # config.enable_feature :cmor_seo, {}
end