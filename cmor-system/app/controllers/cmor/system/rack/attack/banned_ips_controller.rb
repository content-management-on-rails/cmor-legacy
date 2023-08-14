module Cmor
  module System
    module Rack
      module Attack
        class BannedIpsController < Cmor::Core::Backend::ResourcesController::Base
          def self.engine_class
            Cmor::System::Engine
          end

          def self.resource_class
            Cmor::System::Rack::Attack::BannedIp
          end
    
          def self.available_rest_actions
            %i(index show new create destroy)
          end
    
          private
    
          def permitted_params
            params.require(:rack_attack_banned_ip).permit(:key)
          end
        end
      end
    end
  end
end
