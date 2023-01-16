module Cmor
  module Seo
    class GenerateResourceClassesMetaTagsService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
      end

      attr_accessor :resource_classes

      validates :resource_classes, presence: true

      private

      def _perform
        resource_classes.reject(&:blank?).each do |resource_class|
          say "Generating meta tags for #{constantize_resource_class(resource_class).model_name.human(count: :other)}" do
            generate_meta_tags_for!(resource_class)
          end
        end
      end

      def generate_meta_tags_for!(resource_class)
        constantize_resource_class(resource_class).find_in_batches do |batch|
          say "Generating meta tags for #{batch.size} resources" do
            result = Cmor::Seo::GenerateMetaTagsService.call({resources: batch}, {autosave: autosave?})
            @messages.push(*result.messages)
            if result.failed?
              add_error_and_say(resource_class.to_s.underscore, result.errors.full_messages.to_sentence)
            end
          end
        end
      end

      def constantize_resource_class(resource_class)
        resource_class.respond_to?(:constantize) ? resource_class.constantize : resource_class
      end
    end
  end
end
