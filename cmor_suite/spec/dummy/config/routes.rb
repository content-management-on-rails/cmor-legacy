Rails.application.routes.draw do






























  localized do
    mount Cmor::Carousels::Backend::Engine, at: '/backend/cmor-carousels-backend-engine'
  end
  localized do
    mount Cmor::Blog::Backend::Engine, at: '/backend/cmor-blog-backend-engine'
  end
  mount Cmor::Blog::Engine, at: '/'
  mount Cmor::UserArea::Engine, at: '/'
  localized do
    mount Cmor::UserArea::Backend::Engine, at: '/backend/cmor-user-area-backend-engine'
  end
  localized do
    mount Cmor::Tags::Backend::Engine, at: '/backend/cmor-tags-backend-engine'
  end
  localized do
    mount Cmor::Rbac::Backend::Engine, at: '/backend/cmor-rbac-backend-engine'
  end
  localized do
    mount Cmor::Links::Backend::Engine, at: '/backend/cmor-links-backend-engine'
  end
  localized do
    mount Cmor::Galleries::Backend::Engine, at: '/backend/cmor-galleries-backend-engine'
  end
  localized do
    mount Cmor::Files::Backend::Engine, at: '/backend/cmor-files-backend-engine'
  end
  localized do
    mount Cmor::Core::Backend::Engine, at: '/backend/cmor-core-backend-engine'
  end
  localized do
    mount Cmor::Contact::Backend::Engine, at: '/backend/cmor-contact-backend-engine'
  end
  localized do
    mount Cmor::Cms::Backend::Engine, at: '/backend/cmor-cms-backend-engine'
  end
  mount Cmor::Tags::Engine, at: '/'
  mount Cmor::Links::Engine, at: '/'
  mount Cmor::Galleries::Engine, at: '/'
  mount Cmor::Files::Engine, at: '/'
  mount Cmor::Core::Engine, at: '/'
  mount Cmor::Contact::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  localized do
    mount Administrador::Engine, at: '/administrador-engine'
  end

  mount Cmor::Cms::Engine, at: '/' # This one is greedy and has to go last!

  root to: redirect("/#{I18n.locale}")
end
