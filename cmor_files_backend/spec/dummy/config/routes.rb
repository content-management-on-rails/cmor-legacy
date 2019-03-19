Rails.application.routes.draw do
  mount Cmor::Files::Backend::Engine => "/cmor/files/backend"
end
