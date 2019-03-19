Rails.application.routes.draw do
  mount Cmor::UserArea::Engine, at: '/'

  localized do
    get '/', to: 'home#index'
  end

  root to: redirect("/#{I18n.locale}")
end
