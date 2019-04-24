require_dependency 'redcloth'

class Cmor::Links::Link < ActiveRecord::Base
    include Markup::Rails::ActiveRecord

  # acts as list
  acts_as_list scope: :category

  # associations
  belongs_to :category, optional: true

  acts_as_markup :description, Cmor::Core::Configuration.default_markup_options

  # validations
  validates :name, presence: true
  validates :url,  presence: true
end
