Cmor::Suite.configure do |config|
<% sub_modules.each do |submodule| %>
  <%= "  config.administrador.register_engine 'Cmor::#{submodule.camelize}::Backend::Engine', {}" %>
<% end %>

  config.administrador.enable_feature :kaminari,  {}
  config.administrador.enable_feature :rao_query, {}

  config.administrador.base_controller_class_name = '::BackendController'
end
