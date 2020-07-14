# frozen_string_literal: true

module Cmor
  module Transports
    class ExportSidebarsController < Administrador::SidebarController::Base
      def self.icon_name
        :'file-export'
      end
    end
  end
end
