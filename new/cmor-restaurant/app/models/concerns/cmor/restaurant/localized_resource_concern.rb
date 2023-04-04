module Cmor
  module Restaurant
    module LocalizedResourceConcern
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
  end
end
