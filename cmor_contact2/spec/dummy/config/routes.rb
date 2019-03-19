Rails.application.routes.draw do
  mount Cmor::Contact::Engine, at: '/'
end
