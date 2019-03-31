module Cmor
  module Cms
    # Usage:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Cms::NavigationViewHelper, as: :cms_navigation_helper
    #     end
    #
    class NavigationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # This will render a bootstrap 4 compatible navigation
      #     = cms_navigation_helper(self).render(
      #       :main,
      #       renderer: :list,
      #       container_css_class: 'navbar-nav',
      #       selected_class: 'active',
      #       item_html: { class: 'nav-item' },
      #       link_html: { class: 'nav-link' }
      #      )
      #
      def render(name, options = {})
        options.reverse_merge!(
          renderer:       :bootstrap,
          expand_all:     true,
          level:          1,
          selected_class: nil,
          item_html:      {},
          link_html:      {}
        )

        level               = options.delete(:level)
        expand_all          = options.delete(:expand_all)
        container_css_class = options.delete(:container_css_class)
        renderer            = options.delete(:renderer)
        selected_class      = options.delete(:selected_class)
        item_html           = options.delete(:item_html)
        link_html           = options.delete(:link_html)

        level_as_array = (level).is_a?(Range) ? level.to_a : [level]

        navigation = Cmor::Cms::Navigation.where(name: name.to_s, locale: I18n.locale.to_s).first
        if navigation.nil? && (locale = Cmor::Cms::Configuration.navigation_locale_fallback.call(name, I18n.locale))
          navigation = Cmor::Cms::Navigation.where(name: name.to_s, locale: locale).first
        end
        unless navigation
          return I18n.t('cmor.cms.navigation.messages.not_found', lang: I18n.locale.to_s, name: name.to_s)
        end

        roots = navigation.navigation_items.roots.all
        if roots.empty?
          return I18n.t('cmor.cms.navigation.messages.empty', lang: I18n.locale.to_s, name: name)
        end

        c.render_navigation(level: level, expand_all: expand_all, renderer: renderer) do |navigation|
          navigation.dom_class = container_css_class
          navigation.selected_class = selected_class unless selected_class.nil?
          roots.each do |navigation_item|
            build_navigation_item(navigation, navigation_item, container_css_class, item_html, link_html)
          end
        end
      end

      private

      def build_navigation_item(navigation, item, container_css_class, item_html = {}, link_html = {})
        options = {}
        options[:highlights_on] = /#{item.highlights_on}/ if item.highlights_on.present?
        options[:html] = item.li_attributes.marshal_dump.delete_if { |_key, value| value.blank? }

        options.reverse_merge!(html: item_html.dup, link_html: link_html)

        navigation.dom_class = container_css_class
        if item.children.present?
          navigation.item(item.key, item.name, item.url, options) do |sub_navigation|
            item.children.each do |sub_item|
              build_navigation_item(sub_navigation, sub_item, container_css_class, item_html, link_html)
            end
          end
        else
          navigation.item item.key, item.name, item.url, options
        end
      end
    end
  end
end
