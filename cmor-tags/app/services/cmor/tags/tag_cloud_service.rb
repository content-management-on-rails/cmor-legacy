module Cmor
  module Tags
    class TagCloudService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :tag_cloud
      end

      attr_accessor :limit

      validates :limit, presence: true, numericality: {greater_than: 0}

      private

      def _perform
        @result.tag_cloud = fetch_tag_cloud
      end

      def limit
        @limit ||= 25
      end

      def fetch_tag_cloud
        Cmor::Tags::Tag.order(taggings_count: :desc).limit(limit).all
      end
    end
  end
end
