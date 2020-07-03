Cmor::Cms::Engine.routes.draw do
  localized do
    get '/*page', to: 'page#respond', as: :page, constraints: lambda { |req|
      req.path.exclude? 'rails/active_storage'
    }
    get '/',      to: 'page#respond', page: 'home'
  end
end
