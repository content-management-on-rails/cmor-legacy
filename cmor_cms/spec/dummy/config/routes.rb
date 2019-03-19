Rails.application.routes.draw do
  localized do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    resources :page_test, only: [:index]

    Cmor::Cms::Routing.routes(self)
  end

  root to: redirect("/#{I18n.locale}")
end
