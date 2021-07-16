Cmor::Security.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[
  #            Cmor::Security::AntivirusConfigurationsController
  #          ]}
  # 
  config.resources_controllers = -> {[
    Cmor::Security::AntivirusConfigurationsController
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

  # Set the active storage attachments that will be scanned for viruses with
  # tatoru.io.
  #
  # Default: config.enable_antivirus_for = {}
  #
  config.enable_antivirus_for = {}
end
