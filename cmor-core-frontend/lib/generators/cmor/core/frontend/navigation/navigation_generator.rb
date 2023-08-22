module Cmor
  module Core
    module Frontend
      module Generators
        class NavigationGenerator < Rails::Generators::Base
          desc 'Creates a navigation'

          source_root File.expand_path('../templates', __FILE__)

          class_option :name, type: 'string', default: 'main', aliases: '-n'
          class_option :locales, type: 'array', default: I18n.available_locales, aliases: '-l'
          class_option :force, type: 'boolean', default: false, aliases: '-f'
          class_option :modules, type: 'array', default: %w(Cmor::Blog::Engine Cmor::Galleries::Engine Cmor::Files::Engine Cmor::Tags::Engine Cmor::Contact::Engine), aliases: '-m'


          def generate_navigation
            ActiveRecord::Base.transaction do
              remove_navigation if force?
              locales.each do |locale|
                navigation = find_or_create_navigation(locale)
                modules.each do |modyule|
                  find_or_create_navigation_item(navigation, modyule)
                end
              end
            end
          end
          
          private

          def modules
            @modules ||= options[:modules]
          end

          def force?
            options[:force]
          end

          def remove_navigation
            Cmor::Cms::Navigation.where(name: name, locale: locales).destroy_all
          end

          def locales
            @locales ||= options['locales']
          end

          def name
            @name ||= options['name']
          end

          def find_or_create_navigation(locale)
            Cmor::Cms::Navigation.find_or_create_by!(name: name, locale: locale)
          end

          def find_or_create_navigation_item(navigation, modyule)
            name = nil
            url = nil
            I18n.with_locale(navigation.locale) do
              name = I18n.t("classes.#{modyule.underscore}")
              url  = "/" + I18n.locale.to_s + "/" + I18n.t("routes.#{modyule.underscore}".gsub('/', '_'))
            end
            Cmor::Cms::NavigationItem.where(navigation: navigation, name: name, key: modyule).first_or_initialize.tap do |ni|
              ni.url = url
              ni.save!
            end
          end
        end
      end
    end
  end
end
