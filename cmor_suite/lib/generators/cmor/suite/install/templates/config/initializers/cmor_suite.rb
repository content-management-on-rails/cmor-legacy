Cmor::Suite.configure do |config|
  config.administrador.register_engine 'Cmor::Blog::Backend::Engine',      {}
  config.administrador.register_engine 'Cmor::Carousels::Backend::Engine',   {}
  config.administrador.register_engine 'Cmor::Cms::Backend::Engine',       {}
  config.administrador.register_engine 'Cmor::Contact::Backend::Engine',   {}
  config.administrador.register_engine 'Cmor::Files::Backend::Engine',     {}
  config.administrador.register_engine 'Cmor::Galleries::Backend::Engine', {}
  config.administrador.register_engine 'Cmor::Links::Backend::Engine',     {}
  config.administrador.register_engine 'Cmor::Rbac::Backend::Engine',      {}
  config.administrador.register_engine 'Cmor::UserArea::Backend::Engine',  {}

  config.administrador.enable_feature :kaminari,  {}
  config.administrador.enable_feature :rao_query, {}

  config.administrador.base_controller_class_name = '::BackendController'
end
