module Cmor
  module Suite
    module Generators
      class MigrationsGenerator < Rails::Generators::Base
        desc 'Generates the migrations'

        def generate_active_storage_migrations
          `rails active_storage:install:migrations`
        end
        
        def generate_acts_as_taggable_on_migrations
          `rails acts_as_taggable_on_engine:install:migrations`
        end
        
        def generate_migrations
          %w(blog carousels cms contact files galleries links rbac tags user_area).each do |m|
            `rails cmor_#{m}:install:migrations`
          end
        end
      end
    end
  end
end