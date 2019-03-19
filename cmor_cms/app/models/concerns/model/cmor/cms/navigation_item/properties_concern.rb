require 'active_support/concern'

module Model::Cmor::Cms::NavigationItem
  module PropertiesConcern
    extend ActiveSupport::Concern

    included do
      serialize :properties, OpenStruct
      delegate *Cmor::Cms::Configuration.navigation_item_properties, to: :li_attributes
      delegate *Cmor::Cms::Configuration.navigation_item_properties.collect { |a| "#{a}=".to_sym }, to: :li_attributes
    end

    def highlights_on
      properties.highlights_on ||= nil
    end

    delegate :highlights_on=, to: :properties

    def li_attributes
      properties.li_attributes ||= OpenStruct.new
    end

    delegate :li_attributes=, to: :properties
  end
end
