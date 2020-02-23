Cmor::Legal::Frontend::Engine.routes.draw do
  localized do
    resource :privacy_policy, :only => [:show]
    scope :cmor_legal_frontend_engine do
      resource :cookie_preferences, :only => [:edit, :update]
    end
  end
end
