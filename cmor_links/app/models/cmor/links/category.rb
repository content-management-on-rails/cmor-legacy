require_dependency 'redcloth'

module Cmor::Links
  class Category < ActiveRecord::Base
    include Markup::Rails::ActiveRecord

    # associations
    has_many :links, -> { order(:position) },
             dependent: :destroy

    accepts_nested_attributes_for :links, allow_destroy: true

    # awesome nested set
    acts_as_nested_set
    default_scope { order(lft: :asc) }

    acts_as_markup :short_description, :long_description, Cmor::Core::Configuration.default_markup_options

    # friendly id
    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

    # validations
    validates :locale, presence: true, if: proc { |c| c.parent.nil? }
    validates :locale, absence: true, if: proc { |c| !c.parent.nil? }
    validates :name, presence: true,
                     uniqueness: { scope: [:parent_id] }
    validates :identifier, uniqueness: { scope: [:parent_id] }, allow_nil: true

    def human
      name
    end

    def to_s
      human
    end

    def self.for_actual_locale
      where(locale: I18n.locale)
    end

    def self.for_link_footer
      where(arel_table['link_footer_column'].not_eq(nil)).for_actual_locale
    end

    def links_count
      links.count
    end
  end
end
