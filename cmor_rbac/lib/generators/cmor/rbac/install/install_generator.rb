module Cmor
  module Rbac
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the intializer'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :user_class_name

        def initialize(*args)
          super
          @user_class_name = ENV.fetch('ECM_RBAC_USER_CLASS_NAME') { 'User' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor_rbac.rb'
        end
      end
    end
  end
end