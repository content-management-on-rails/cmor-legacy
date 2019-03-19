module Cmor::Files::Backend
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
