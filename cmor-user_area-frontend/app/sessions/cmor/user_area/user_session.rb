module Cmor
  module UserArea
    class UserSession < ::Cmor::UserArea::Frontend::Session::Base
      params_key "#{name.demodulize.tableize.gsub("_sessions", "")}_api_key"
      generalize_credentials_error_messages true
    end
  end
end
