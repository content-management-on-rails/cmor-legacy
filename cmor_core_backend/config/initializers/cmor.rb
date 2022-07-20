Cmor.configure do |config|
  config.administrador.register_engine('Cmor::Core::Backend::Engine', { show_in_engine_sidebar: false })
end