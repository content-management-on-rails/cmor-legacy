require_dependency 'redcloth'

module Cmor::Links
  class Category < ActiveRecord::Base
    # associations
    has_many :links, -> { order(:position) },
             dependent: :destroy

    accepts_nested_attributes_for :links, allow_destroy: true

    # awesome nested set
    acts_as_nested_set
    default_scope { order(lft: :asc) }

    # callbacks
    after_initialize :set_defaults

    # friendly id
    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

    # validations
    validates :locale, presence: true, if: proc { |c| c.parent.nil? }
    validates :locale, absence: true, if: proc { |c| !c.parent.nil? }
    validates :name, presence: true,
                     uniqueness: { scope: [:parent_id] }
    validates :markup_language, presence: true,
                                inclusion: Configuration.markup_languages.map(&:to_s)

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

    def long_description(options = {})
      options.reverse_merge!(as: :plain)
      case options[:as]
      when :html
        markup(self[:long_description])
      else
        self[:long_description]
      end
    end

    def short_description(options = {})
      options.reverse_merge!(as: :plain)
      case options[:as]
      when :html
        markup(self[:short_description])
      else
        self[:short_description]
      end
    end

    def links_count
      links.count
    end

    private

    def markup(text)
      case markup_language.to_sym
      when :textile
        return unless text
        RedCloth.new(text).to_html
      when :none
        text
      else
        fail "Unsupported markup language #{markup_language}"
      end
    end

    def set_defaults
      if self.new_record?
        self.markup_language ||= Configuration.default_markup_language.to_s
      end
    end
  end
end
