Cmor::MultiTenancy.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.cmor.administrador.register_engine("Cmor::MultiTenancy::Engine", {})
  #
  config.cmor.administrador.register_engine("Cmor::MultiTenancy::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::MultiTenancy::ClientsController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Cmor::MultiTenancy::ClientsController
    ]
  }

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resource_controllers = -> {[]}
  #
  config.resource_controllers = -> { [] }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[]}
  #
  config.service_controllers = -> { [] }

  # Set the sidebars, that will be shown in the backend menu.
  #
  # Default: config.sidebar_controllers = -> {[]}
  #
  config.sidebar_controllers = -> { [] }

  # Set which key to use when redirecting to a client. This can
  # either be :subdomain or :client_identifier
  #
  # Default: config.current_client_key = :subdomain
  #
  config.current_client_key = :subdomain

  # Sets the aliases that will match the default client.
  #
  # Default: aliases_for_default_client = %w( www )
  #
  config.aliases_for_default_client = %w[www]

  # Set the models that will be scoped by client.
  #
  # Example: config.models = -> {{
  #            Cmor::Blog::Post => {}
  #          }}
  #
  # Default: config.scoped_models = -> {{}}
  #
  config.scoped_models = -> { {} }
end
