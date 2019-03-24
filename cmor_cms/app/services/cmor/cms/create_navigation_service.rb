module Cmor::Cms
  class CreateNavigationService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
      attr_accessor :navigation, :navigation_items, :created_navigation_items, :errored_navigation_items
    end

    attr_accessor :locale, :name, :items_attributes

    validates :locale, :name, :items_attributes, presence: true

    private

    def after_initialize
      @created_navigation_items ||= []
      @errored_navigation_items ||= []
    end

    def _perform
      @navigation = build_navigation
      @navigation_items = build_navigation_items
      @navigation_items.collect do |navigation_item|
        if navigation_item.save
          say "Created #{navigation_item}"
          @created_navigation_items << navigation_item
        else
          add_error_and_say :base, "Error creating #{navigation_item}. Errors: #{navigation_item.errors.full_messages.to_sentence}"
          @errored_navigation_items << navigation_item
        end
      end

      @result.navigation               = @navigation
      @result.navigation_items         = @navigation_items
      @result.created_navigation_items = @created_navigation_items
      @result.errored_navigation_items = @errored_navigation_items
    end

    private

    def build_navigation
      Navigation.new(locale: locale, name: name)
    end

    def build_navigation_items
      @items_attributes.collect do |item_attributes|
        NavigationItem.new(item_attributes.merge(cmor_cms_navigation: @navigation))
      end
    end
  end
end