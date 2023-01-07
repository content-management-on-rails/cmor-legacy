module Cmor::Cms
  class Template < ActiveRecord::Base
    # add shared behaviour for database backed templates
    include Cmor::Cms::Models::DatabaseTemplateConcern

    # publishing
    include ActsAsPublished::ActiveRecord
    acts_as_published

    # callbacks
    before_validation :ensure_basename_starts_without_underscore, if: proc { |t| t.basename.present? }

    private

    def ensure_basename_starts_without_underscore
      basename.slice!(0) if basename.start_with?('_')
    end
  end
end
