module Cmor
  module Core
    module Model
      module CollectionConcern
        extend ActiveSupport::Concern

        included do
          include Cmor::Core::Model::LocalizationConcern
          include Cmor::Core::Model::IdentifierConcern

          # acts as published
          include ActsAsPublished::ActiveRecord
          acts_as_published

          # acts as list
          acts_as_list
          default_scope { order(position: :asc) }

          # slugs
          extend FriendlyId
          friendly_id :name, use: :slugged

          validates :name, presence: true, uniqueness: {scope: [:locale]}
        end
      end
    end
  end
end
