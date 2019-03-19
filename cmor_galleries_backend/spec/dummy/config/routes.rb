Rails.application.routes.draw do
  mount Cmor::Galleries::Backend::Engine => "/cmor/galleries/backend"
end
