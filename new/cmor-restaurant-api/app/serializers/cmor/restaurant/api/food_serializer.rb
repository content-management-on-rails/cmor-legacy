module Cmor
  module Restaurant
    module Api
      class FoodSerializer < ApplicationSerializer
        attributes :id,
          :identifier,
          :name,
          :description,
          :slug,
          :category_id,
          :quantity,
          :unit,
          :price,
          :published,
          :published_at,
          :created_at,
          :updated_at,
          :additives

        def unit
          object.unit(locale: I18n.locale)
        end

        def additives
          build_has_many(:additives)
        end
      end
    end
  end
end
