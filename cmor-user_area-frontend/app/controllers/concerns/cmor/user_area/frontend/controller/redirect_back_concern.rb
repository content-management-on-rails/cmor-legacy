module Cmor
  module UserArea
    module Frontend
      module Controller
        module RedirectBackConcern
          extend ActiveSupport::Concern

          private

          def store_location
            self.original_location = request.url if request.get?
          end

          def redirect_back_or(url)
            redirect_to(original_location || url)
            clear_original_location
          end

          def clear_original_location
            session.delete(:original_location)
          end

          def original_location
            session[:original_location]
          end

          def original_location=(location)
            session[:original_location] = location
          end
        end
      end
    end
  end
end
