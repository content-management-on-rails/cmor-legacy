module Cmor::Cms
  class Layout < ApplicationRecord
    # add shared behaviour for database backed templates
    include Cmor::Cms::Models::DatabaseTemplateConcern

    # publishing
    include ActsAsPublished::ActiveRecord
    acts_as_published
  end
end
