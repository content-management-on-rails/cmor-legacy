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


          def generate_navigation
            ActiveRecord::Base.transaction do
              remove_navigation if force?
              locales.each do |locale|
                navigation = create_navigation(locale)
                %w(blog galleries files tags contact).each do |modyule|
                  create_navigation_item(navigation, modyule)
                end
              end
            end
          end
          
          private

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

          def create_navigation(locale)
            Cmor::Cms::Navigation.create!(name: name, locale: locale)
          end

          def create_navigation_item(navigation, modyule)
            name = nil
            url = nil
            I18n.with_locale(navigation.locale) do
              name = I18n.t("classes.cmor/#{modyule}/engine")
              url  = "/" + I18n.locale.to_s + "/" + I18n.t("routes.cmor_#{modyule}_engine")
            end
            Cmor::Cms::NavigationItem.create!(navigation: navigation, name: name, url: url, key: modyule)
          end
        end
      end
    end
  end
end
