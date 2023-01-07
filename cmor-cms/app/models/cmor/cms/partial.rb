module Cmor::Cms
  class Partial < ActiveRecord::Base
    # add shared behaviour for database backed templates
    include Cmor::Cms::Models::DatabaseTemplateConcern

    # publishing
    include ActsAsPublished::ActiveRecord
    acts_as_published

    # callbacks
    before_validation :ensure_basename_starts_with_underscore, if: proc { |t| t.basename.present? }

    private

    def ensure_basename_starts_with_underscore
      basename.insert(0, '_') unless basename.start_with?('_')
    end
  end
end
