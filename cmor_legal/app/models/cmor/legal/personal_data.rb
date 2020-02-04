module Cmor
  module Legal
    class PersonalData
      include ActiveModel::Model

      attr_accessor :root, :options, :block

      def to_hash_with_options
        @hash ||= build_hash_with_options!
      end

      def build_hash_with_options!
        Cmor::Legal::PersonalDataHashBuilder.new({ :root => root, :options => options, :block => block }, { :with_options => true }).hash
      end

      def to_hash
        @hash ||= build_hash!
      end

      def build_hash!
        Cmor::Legal::PersonalDataHashBuilder.new({ :root => root, :options => options, :block => block }, { :with_options => false }).hash
      end

      def self.all
        Cmor::Legal::PersonalDataRegistry.all
      end

      def self.count
        Cmor::Legal::PersonalDataRegistry.count
      end

      def self.attribute_names
        [:root, :options, :block]
      end

      def self.find(id)
        all.find {|x| x.root == id.gsub('-', '/').camelize }
      end

      def id
        root.underscore.gsub('/', '-')
      end

      def to_param
        id
      end

      def to_s
        [self.class.model_name.human, root_model_human].compact.join(' - ')
      end

      def root_model_human
        return if root.nil?
        root.constantize.model_name.human
      end

    end
  end
end
