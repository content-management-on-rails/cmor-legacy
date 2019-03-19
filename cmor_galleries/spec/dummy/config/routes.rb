Rails.application.routes.draw do
  mount Cmor::Galleries::Engine, at: '/'
end
