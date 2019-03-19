module Cmor
  module Contact
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
