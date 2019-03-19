Rails.application.routes.draw do
  localized do
    mount Cmor::Cms::Backend::Engine => '/backend/cmor/cms/'
    mount Itsf::Backend::Engine => '/backend'

    Cmor::Cms::Routing.routes(self)
  end

  root to: redirect("/#{I18n.locale}")
end
