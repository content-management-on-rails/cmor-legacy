require_dependency 'model/cmor/cms/navigation_item/properties_concern'

module Cmor::Cms
  class NavigationItem < ActiveRecord::Base
    include Model::Cmor::Cms::NavigationItem::PropertiesConcern

    # associations
    belongs_to :navigation,
               optional: true
    belongs_to :page,
               optional: true

    # awesome nested set
    acts_as_nested_set dependent: :destroy, counter_cache: :children_count, scope: :navigation_id

    # callbacks
    before_validation :update_navigation_from_parent, if: proc { |ni| ni.child? }
    before_validation :update_url_form_page, if: proc { |ni| ni.page.present? && ni.url.blank? }
    after_save :update_children_navigations!

    # default_scope
    default_scope { order(:navigation_id, :lft) }

    # validations
    validates :key, presence: true
    validates :name, presence: true
    validates :url, presence: true
    validates :navigation, presence: true, if: -> { parent.nil? }

    def params_for_new_page
      return {} if self.new_record?
      match = url.scan(/(#{I18n.available_locales.join('|')})$/)
      return { locale: match[0][0], pathname: '/', basename: 'home', title: name, navigation_item_ids: [to_param] } if match.size > 0
      match = url.scan(/(#{I18n.available_locales.join('|')})(.*)\/(.*)/)
      return {} unless match.first.respond_to?(:size) # && match.first.size != 3
      params = match.first
      return {} if params.size != 3
      params[1] << '/' unless params[1].end_with?('/')
      { locale: params[0], pathname: params[1], basename: params[2], title: name, navigation_item_ids: [to_param] }
    end

    def to_label
      if depth > 0
        "#{'&nbsp;' * depth} &#9654; #{name}".html_safe
      else
        name
      end
    end

    def to_s
      "#{navigation.human}: #{name}"
    end

    def update_navigation_from_parent!
      update_navigation_from_parent
      save!
    end

    def update_children_navigations!
      descendants.map(&:"update_navigation_from_parent!")
    end

    def update_url_form_page!
      update_url_form_page
      save!
    end

    private

    def build_url_from_page(locale, pathname, basename, is_home_page)
      if is_home_page
        "/#{locale}"
      else
        "/#{locale}#{pathname}#{basename}"
      end
    end

    def update_navigation_from_parent
      self.navigation = parent.navigation
    end

    def update_url_form_page
      self.url = build_url_from_page(page.locale, page.pathname, page.basename, page.home_page?)
    end
  end
end
