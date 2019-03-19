module Cmor
  module UserArea
    class UserSession < Session::Base
      params_key "#{self.name.demodulize.tableize.gsub('_sessions', '')}_api_key"
      generalize_credentials_error_messages true
    end
  end
end