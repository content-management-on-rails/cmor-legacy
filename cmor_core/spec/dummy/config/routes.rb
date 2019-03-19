Rails.application.routes.draw do
  mount Cmor::Core::Engine => "/cmor-core"
end
