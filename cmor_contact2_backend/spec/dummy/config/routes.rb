Rails.application.routes.draw do
  localized do
    mount Itsf::Backend::Engine, at: '/backend'

    mount Cmor::Contact::Backend::Engine, at: '/backend/cmor-contact-backend-engine'

    root to: proc { [200, {}, ['<h1>root</h1>']] }
  end
end
