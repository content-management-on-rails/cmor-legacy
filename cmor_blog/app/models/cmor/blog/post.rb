module Cmor
  module Blog
    class Post < ActiveRecord::Base
      include Model::Cmor::Comments::CommentableConcern if Cmor::Core.features?(:cmor_comments)
      include Model::Cmor::Tags::TaggableConcern if Cmor::Core.features?(:cmor_tags)

      # publishing
      include ActsAsPublished::ActiveRecord
      acts_as_published

      # positioning
      acts_as_list
      default_scope { order(position: :desc) }

      # slugs
      extend FriendlyId
      friendly_id :title, use: :slugged

      belongs_to :creator, class_name: Cmor::Blog.creator_class_name, foreign_key: 'created_by_id', optional: true
      belongs_to :updater, class_name: Cmor::Blog.creator_class_name, foreign_key: 'updated_by_id', optional: true

      scope :for_date, ->(year, month, day) { where(created_at: "#{year}-#{month || 1}-#{day || 1}".to_date.beginning_of_month.."#{year}-#{month || 1}-#{day || 1}".to_date.end_of_month) }

      validates :title, :body, presence: true

      def human
        title
      end

      module Markdown
        def body(format: nil)
          case format
          when :html
            markdown_to_html(read_attribute(:body))
          else
            read_attribute(:body)
          end
        end

        private

        def markdown_to_html(string)
          instance_exec(string, &Cmor::Blog::Configuration.markdown_to_html_proc)
        end
      end

      include Markdown

      module AssetDetailsConcern
        extend ActiveSupport::Concern

        included do
          has_many :asset_details, inverse_of: :post, dependent: :destroy
        end

        def asset_details_count
          asset_details.count
        end

        def append_asset_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            asset_details << clean_collection.map { |r| asset_details.build.tap{ |ad| ad.asset.attach(r) } }
          end
        end

        def append_asset_detail_assets
          asset_details
        end

        def overwrite_asset_detail_assets=(collection)
          clean_collection = collection.keep_if { |r| r.present? }
          if clean_collection.any?
            asset_details.replace(clean_collection.map { |r| asset_details.build.tap { |ad| ad.asset.attach(r) } })
          end
        end

        def overwrite_asset_detail_assets
          asset_details
        end
      end

      include AssetDetailsConcern

      module PreviewPictureConcern
        extend ActiveSupport::Concern

        def preview_picture
          asset_details.images.first
        end
      end

      include PreviewPictureConcern

      include Cmor::Core::Model::LocalizationConcern
    end
  end
end
