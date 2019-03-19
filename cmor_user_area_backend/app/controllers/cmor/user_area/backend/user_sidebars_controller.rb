module Cmor
  module UserArea
    module Backend
      class UserSidebarsController < Administrador::SidebarController::Base
        def self.icon_name
          :user
        end
      end
    end
  end
end
