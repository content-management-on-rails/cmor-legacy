module Cmor::Restaurant
  class Food < ApplicationRecord
    include ::Cmor::Restaurant::ResourceConcern

    belongs_to :category, inverse_of: :foods
    has_many :food_additives, inverse_of: :food, dependent: :destroy
    has_many :additives, through: :food_additives
    has_many :food_allergens, inverse_of: :food, dependent: :destroy
    has_many :allergens, through: :food_allergens

    acts_as_list scope: :category
    default_scope { order(:category_id, :position) }

    monetize :price_cents

    validates :quantity, numericality: {greater_than: 0}

    def unit(locale: nil)
      return read_attribute(:unit) if locale.nil?
      I18n.t("activerecord.values.#{self.class.name.underscore}.unit.#{read_attribute(:unit)}", locale: locale)
    end
  end
end
