Cmor::Cms::Engine.routes.draw do
  localized do
    get '/*page', to: 'page#respond', as: :page
    get '/',      to: 'page#respond', page: 'home'
  end
end
