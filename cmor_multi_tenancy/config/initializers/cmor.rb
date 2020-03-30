Cmor.configure do |config|
  config.administrador.register_engine('Cmor::MultiTenancy::Engine', {})
end