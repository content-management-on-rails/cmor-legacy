Rails.application.routes.draw do
  mount Cmor::Api::Engine => "/cmor_api"
end
