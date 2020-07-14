Cmor::Audits.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[
  #   Cmor::Audits::PaperTrail::VersionsController,
  # ]}
  # 
  config.resources_controllers = -> {[
    Cmor::Audits::PaperTrail::VersionsController,
  ]}

  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resource_controllers = -> {[]}
  # 
  config.resource_controllers = -> {[]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.service_controllers = -> {[]}
  # 
  config.service_controllers = -> {[]}

  # Set the sidebars, that will be shown in the backend menu.
  # 
  # Default: config.sidebar_controllers = -> {[]}
  # 
  config.sidebar_controllers = -> {[]}

  # Specify the models that will be audited. Listing models here is the same
  # as adding has_paper_trail to the model class directly. The hash is passed
  # to has_paper_trail as options hash.
  #
  # Example: config.resources = -> { { "Post" => { on: [:update] } } }
  #
  # Default: config.resources = -> { {} }
  #
  config.resources = -> { {} }
end
