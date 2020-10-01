module Cmor
  module System
    module ActiveCollection
      class Base
        if Object.const_defined?('Kaminari')
          class Collection < Kaminari::PaginatableArray
          end
        else
          class Collection < Array
          end
        end

        extend ActiveModel::Model
        extend ActiveModel::Naming
        include ActiveModel::Conversion
        extend ActiveModel::Translation
        include ActiveModel::Validations
        include Markup::Rails::ActiveRecord

        module AttributesConcern
          extend ActiveSupport::Concern

          included do
            class_attribute :attribute_names
            attr_accessor :attributes

            delegate :[], to: :attributes
          end

          def method_missing(m, *args, &block)
            if self.attribute_names.map(&:to_s).include?(m.to_s)
              return @attributes[m.to_s]
            elsif self.attribute_names.map { |an| "#{an}=" }.include?(m.to_s)
              return @attributes[m.to_s[0..-2]] = args.first
            else
              super
            end
          end

          def initialize(attributes = {})
            @attributes = {}.with_indifferent_access
            attributes.each do |k, v|
              self.send("#{k}=", v)
            end
          end
        end

        include AttributesConcern

        module ActiveRecordLikeConcern
          extend ActiveSupport::Concern

          class_methods do
            def reorder(order)
              key = order.first[0].to_sym
              value = order.first[1].to_sym
              sorted = _all.sort { |a, b| a.send(key) <=> b.send(key) }
              value == :asc ? sorted : sorted.reverse
              Collection.new(value == 'asc' ? sorted : sorted.reverse)
            end

            def count
              all.size
            end

            def first
              all.first
            end

            def last
              all.last
            end

            def _all
              raise "Child class responsiblity"
            end

            def all
              Collection.new(_all)
            end

            def destroy_all
              all.map(&:destroy)
            end

            def find(id)
              all.select { |cl| cl.id == id }.first || raise(ActiveRecord::RecordNotFound)
            end

            def columns_hash
              @columns_hash ||= attribute_names.each_with_object({}) { |e, m| m[name] = {} }
            end

            def create(attributes = {})
              new(attributes).save
            end
          end

          def ==(other)
            return false unless other.respond_to?(:attributes)
            self.attributes == other.attributes
          end

          def to_key
            [id]
          end

          def to_param
            id
          end

          def persisted?
            true
          end

          def read_attribute(name)
            @attributes[name.to_sym]
          end

          def write_attribute(name, value)
            @attributes[name.to_sym] = value
          end

          def update(attributes)
            raise "Child class responsibility"
          end

          def save
            raise "Child class responsibility"
          end

          def save!
            save
          end
        end

        include ActiveRecordLikeConcern

        module PaginationConcern
          extend ActiveSupport::Concern

          class_methods do
            def page(page)
              all.page(page)
            end
          end
        end

        include PaginationConcern
      end
    end
  end
end
