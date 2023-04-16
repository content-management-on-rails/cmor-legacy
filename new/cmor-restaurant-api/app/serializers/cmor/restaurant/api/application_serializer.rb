module Cmor
  module Restaurant
    module Api
      class ApplicationSerializer < ActiveModel::Serializer
        def attributes(*args)
          super.deep_transform_keys! { |key| key.to_s.camelize(:lower) }
        end

        def build_has_many(association_name, serializer: nil)
          {
            data: object.send(association_name).map do |record|
              {
                id: record.id,
                attributes: (serializer.nil? ? record : serializer.new(record)).attributes.except(:id)
              }
            end,
            meta: {
              attribute_names: object.class.reflect_on_association(association_name).klass.attribute_names.each_with_object({}) { |a, h| h[a] = Cmor::Restaurant::Food.human_attribute_name(a) }
            }
          }
        end
      end
    end
  end
end
