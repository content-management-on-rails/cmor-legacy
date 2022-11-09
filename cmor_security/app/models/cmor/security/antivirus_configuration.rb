module Cmor
  module Security
    class AntivirusConfiguration < Cmor::Core::ActiveCollection::Base
      self.attribute_names = %w(model_class_name attachment_name options)

      validates :model_class_name, :attachment_name, :options, presence: true

      def self._all
        Configuration.antivirus_enabled_models.values
      end

      def id
        Digest::SHA1.hexdigest([model_class_name, attachment_name].join("#"))
      end

      def model_class
        @model_class ||= model_class_name.constantize
      end
    end
  end
end
