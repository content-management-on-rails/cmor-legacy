module Cmor
  module Core
    module Frontend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor(:first_breadcrumb) do
          ->() { Cmor::Core::Frontend::Breadcrumb::Base.new(label: t('.home'), url: c.main_app.root_path) }
        end

        mattr_accessor(:resource_label_methods) do
          %i(human name email to_s)
        end
      end
    end
  end
end
