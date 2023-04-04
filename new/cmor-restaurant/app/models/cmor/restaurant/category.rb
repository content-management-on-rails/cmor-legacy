module Cmor::Restaurant
  class Category < ApplicationRecord
    module ResourceConcern
      extend ActiveSupport::Concern

      included do
        include ActsAsPublished::ActiveRecord
        acts_as_published

        validates :locale, inclusion: {in: I18n.available_locales.map(&:to_s)}, allow_blank: true
        validates :identifier, presence: true, uniqueness: {scope: :locale}
        validates :name, presence: true, uniqueness: {scope: :locale}

        extend FriendlyId
        friendly_id :name, use: :slugged
      end

      def human
        name
      end
    end

    module NestedCollectionConcern
      extend ActiveSupport::Concern

      included do
        acts_as_nested_set
        default_scope { order(:lft) }
      end
    end

    include ResourceConcern
    include NestedCollectionConcern
  end
end
