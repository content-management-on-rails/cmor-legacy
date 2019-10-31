module Cmor
  module Suite
    module Generators
      class MigrationsGenerator < Rails::Generators::Base
        desc 'Generates the migrations'

        class_option :excluded_modules, type: 'array', default: [], aliases: '-e'

        def generate_active_storage_migrations
          `rails active_storage:install:migrations` if needs_active_storage?
        end
        
        def generate_acts_as_taggable_on_migrations
          `rails acts_as_taggable_on_engine:install:migrations` if needs_acts_as_taggable?
        end
        
        def generate_migrations
          sub_modules.each do |m|
            `rails cmor_#{m}:install:migrations`
          end
        end

        private

        def sub_modules
          @sub_modules ||= %w(blog carousels cms contact files galleries links partners rbac seo showcase tags testimonials user_area) - options['excluded_modules']
        end

        def needs_active_storage?
          (%w(blog carousels files galleries partners showcase testimonials) & sub_modules).any?
        end

        def needs_acts_as_taggable?
          (%w(tags) & sub_modules).any?
        end
      end
    end
  end
end