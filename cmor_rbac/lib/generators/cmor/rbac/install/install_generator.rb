module Cmor
  module Rbac
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the intializer'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :user_class_name, :user_factory_name

        def initialize(*args)
          super
          @user_class_name = ENV.fetch('CMOR_RBAC_USER_CLASS_NAME') { 'User' }
          @user_factory_name = ENV.fetch('CMOR_RBAC_USER_FACTORY_NAME') { 'user' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor_rbac.rb'
        end
      end
    end
  end
end