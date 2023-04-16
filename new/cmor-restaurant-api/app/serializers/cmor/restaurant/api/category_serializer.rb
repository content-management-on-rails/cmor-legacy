module Cmor
  module Restaurant
    module Api
      class CategorySerializer < ApplicationSerializer
        attributes :id,
          :locale,
          :identifier,
          :name,
          :description,
          :slug,
          :parent_id,
          :lft,
          :rgt,
          :depth,
          :children_count,
          :published,
          :published_at,
          :created_at,
          :updated_at,
          :foods

        def foods
          build_has_many(:foods, serializer: Cmor::Restaurant::Api::FoodSerializer)
        end

        # has_many :foods, serializer: Cmor::Restaurant::Api::FoodSerializer, if: -> { ActiveModel::Type::Boolean.new.cast(@instance_options.dig(:populate, :foods)) }

        #        def foods
        #          { data: object.foods.map { |f| build_food(f) }, meta: {
        #            attribute_names: Cmor::Restaurant::Food.attribute_names.each_with_object({}) { |a, h| h[a] = Cmor::Restaurant::Food.human_attribute_name(a) }
        #          } }
        #        end
        #
        #        def build_food(food)
        #          {
        #            id: food.id,
        #            attributes: Cmor::Restaurant::Api::FoodSerializer.new(food).attributes.except(:id)
        #          }
        #        end
      end
    end
  end
end
