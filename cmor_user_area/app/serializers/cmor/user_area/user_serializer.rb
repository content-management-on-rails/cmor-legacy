module Cmor
  module UserArea
    class UserSerializer < ActiveModel::Serializer
      attributes %w(id email single_access_token login_count failed_login_count last_request_at current_login_at last_login_at current_login_ip last_login_ip active approved confirmed created_at updated_at)
    end
  end
end