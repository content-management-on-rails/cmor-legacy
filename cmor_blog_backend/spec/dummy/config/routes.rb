Rails.application.routes.draw do






  localized do
    mount Cmor::Blog::Backend::Engine, at: '/backend/cmor-blog-backend-engine'
  end
  mount Cmor::Blog::Engine, at: '/'
  localized do
    mount Cmor::Core::Backend::Engine, at: '/backend/cmor-core-backend-engine'
  end
  mount Cmor::Core::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
