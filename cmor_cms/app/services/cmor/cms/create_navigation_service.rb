module Cmor::Cms
  class CreateNavigationService < Itsf::Services::V2::Service::Base
    class Response < Itsf::Services::V2::Response::Base
      attr_accessor :navigation, :navigation_items, :created_navigation_items, :errored_navigation_items

      def initialize
        super
        @navigation_items          = []
        @created_navigation_items  = []
        @errrored_navigation_items = []
      end
    end

    attr_accessor :locale, :name, :items_attributes

    validates :locale, :name, :items_attributes, presence: true

    def do_work
      info "Running on environment #{Rails.env}"
      return response unless valid?
      @navigation = build_navigation
      @navigation_items = build_navigation_items
      @navigation_items.collect do |navigation_item|
        if navigation_item.save
          info "Created #{navigation_item}", indent: 1
          response.created_navigation_items << navigation_item
        else
          add_error_and_say :base, "Error creating #{navigation_item}. Errors: #{navigation_item.errors.full_messages.to_sentence}", indent: 1
          response.errored_navigation_items << navigation_item
        end
      end
      response.navigation = @navigation
      response.navigation_items = @navigation_items
      info 'Done'
      return response
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