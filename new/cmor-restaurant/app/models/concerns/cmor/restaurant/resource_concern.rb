module Cmor
  module Restaurant
    module ResourceConcern
      extend ActiveSupport::Concern

      included do
        include ActsAsPublished::ActiveRecord
        acts_as_published

        validates :identifier, presence: true, uniqueness: true
        validates :name, presence: true, uniqueness: true

        extend FriendlyId
        friendly_id :name, use: :slugged
      end

      def human
        name
      end
    end
  end
end
