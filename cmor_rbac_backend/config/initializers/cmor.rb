Cmor.configure do |config|
  config.administrador.register_engine('Cmor::Rbac::Backend::Engine', {})
end