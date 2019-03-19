Rails.application.routes.draw do
  mount Cmor::Carousels::Backend::Engine => "/cmor/carousels/backend"
end
