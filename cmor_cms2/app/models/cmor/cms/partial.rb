require 'cmor/cms/database_template'

class Cmor::Cms::Partial < ActiveRecord::Base
  # add shared behaviour for database backed templates
  include Cmor::Cms::DatabaseTemplate

  # callbacks
  before_validation :ensure_basename_starts_with_underscore, if: proc { |t| t.basename.present? }

  private

  def ensure_basename_starts_with_underscore
    basename.insert(0, '_') unless basename.start_with?('_')
  end
end
