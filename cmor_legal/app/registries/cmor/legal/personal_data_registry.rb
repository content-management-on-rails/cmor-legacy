# frozen_string_literal: true

module Cmor
  module Legal
    class PersonalDataRegistry
      extend ActiveModel::Translation
      extend ActiveModel::Naming

      attr_accessor :personal_data

      delegate :first, :last, :[], :each, :map, :collect, to: :personal_data

      def initialize
        @personal_data = []
      end

      def self.instance
        @@instance
      end

      def self.all
        instance.personal_data
      end

      def self.count
        instance.personal_data.size
      end

      def self.attribute_names
        [:personal_data]
      end

      def register(root, options, &block)
        self.personal_data << PersonalData.new(root: root, options: options, block: block)
      end

      @@instance = Cmor::Legal::PersonalDataRegistry.new

      private_class_method :new
    end
  end
end
