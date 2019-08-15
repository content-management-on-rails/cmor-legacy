module Cmor
  module Core
    module Frontend
      module Breadcrumb
        module I18nConcern
          extend ActiveSupport::Concern

          def t(identifier, options = {})
            if identifier.start_with?('.')
              prefix = self.class.name.underscore

              # Check if we are in a proc by matching the caller string
              caller_method = if caller[0] =~ /\(required\)>/
                                # If yes omit the last call (that has to be instance_exec) and
                                # fetch the previous one that should be the method that is really
                                # calling us.
                                caller[2].split(' ').last.gsub("'", '').gsub("`", '')
                              else
                                # Otherwise take the first caller
                                caller[0].split(' ').last.gsub("'", '').gsub("`", '')
                              end

              I18n.t("#{prefix}.#{caller_method}.#{identifier}", options)
            else
              I18n.t(identifier, options)
            end
          end
        end
      end
    end
  end
end