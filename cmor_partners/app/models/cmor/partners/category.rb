module Cmor::Partners
  class Category < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    has_many :partners, dependent: :destroy
    has_one_attached :image

    acts_as_list
    acts_as_published

    validates :locale, presence: true
    validates :identifier, presence: true, uniqueness: true
    validates :name, presence: true, uniqueness: true
  end
end
