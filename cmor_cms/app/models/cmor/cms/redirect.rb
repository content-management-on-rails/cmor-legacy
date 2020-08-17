module Cmor
  module Cms
    class Redirect < ApplicationRecord
      include ActsAsPublished::ActiveRecord
      acts_as_published

      acts_as_list

      validates :source, presence: true
      validates :target, presence: true
    end
  end
end
