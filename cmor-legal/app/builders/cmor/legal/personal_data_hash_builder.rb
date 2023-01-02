# frozen_string_literal: true

module Cmor
  module Legal
    class PersonalDataHashBuilder
      include ActiveModel::Model
      attr_accessor :root, :options, :block

      def initialize(attributes, options = {})
        super(attributes)
        @builder_options = options
        invoke_block
      end

      def attribute(name, options = {})
        if with_options?
          hash[:attributes][name] = {options: options}
        else
          hash[:attributes] << name
        end
      end

      def association(name, options = {}, &block)
        if with_options?
          hash[:associations][name] = {options: options, attributes: Cmor::Legal::PersonalDataHashBuilder.new(block: block).hash}
        else
          hash[name] = Cmor::Legal::PersonalDataHashBuilder.new({block: block}, @builder_options).hash
        end
      end

      def hash
        @hash ||= if with_options?
          {root: root, options: options, attributes: {}, associations: {}}
        else
          {attributes: []}
        end
      end

      private

      def invoke_block
        block.call(self)
      end

      def with_options?
        @builder_options[:with_options] = true if @builder_options[:with_options].nil?
        @builder_options[:with_options]
      end
    end
  end
end
