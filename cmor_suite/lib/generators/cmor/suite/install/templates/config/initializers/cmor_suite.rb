Cmor::Suite.configure do |config|
<% (legacy_sub_modules - ['core']).each do |submodule| %>
  <%= "config.administrador.register_engine 'Cmor::#{submodule.camelize}::Backend::Engine', {}" %>
<% end %>
<% (sub_modules - ['core']).each do |submodule| %>
  <%= "config.administrador.register_engine 'Cmor::#{submodule.camelize}::Engine', {}" %>
<% end %>

  config.administrador.enable_feature :kaminari,  {}
  config.administrador.enable_feature :rao_query, {}

  config.administrador.base_controller_class_name = '::BackendController'
end
