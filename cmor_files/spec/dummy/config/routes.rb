Rails.application.routes.draw do
  mount Cmor::Files::Engine, at: '/'
end
