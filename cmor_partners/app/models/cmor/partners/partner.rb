module Cmor::Partners
  class Partner < ApplicationRecord
    include ActsAsPublished::ActiveRecord
    include Markup::Rails::ActiveRecord

    belongs_to :category

    has_one_attached :logo
    
    acts_as_list scope: :category
    acts_as_published
    acts_as_markup :body, Cmor::Core::Configuration.default_markup_options

    validates :name, presence: true, uniqueness: { scope: [ :category_id ] }  
  end
end
