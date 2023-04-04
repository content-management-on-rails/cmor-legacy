module Cmor::Restaurant
  class Category < ApplicationRecord
    include ::Cmor::Restaurant::LocalizedResourceConcern
    include ::Cmor::Restaurant::NestedCollectionConcern

    has_many :foods, inverse_of: :category, dependent: :destroy

    validates :locale, inclusion: {in: I18n.available_locales.map(&:to_s)}, allow_blank: true
  end
end
