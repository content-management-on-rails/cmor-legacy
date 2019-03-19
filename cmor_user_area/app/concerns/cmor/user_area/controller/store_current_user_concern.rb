module Cmor
  module UserArea
    module Controller
      module StoreCurrentUserConcern
        extend ActiveSupport::Concern

        included do
          before_action :store_current_user_id
          before_action :store_current_user
        end

        private

        def store_current_user_id
          RequestLocals.store[:current_user_id] = current_user.try(:id)
        end


        def store_current_user
          RequestLocals.store[:current_user] = current_user
        end
      end
    end
  end
end
