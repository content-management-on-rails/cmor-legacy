module Cmor::Transports
  class System < ApplicationRecord
    has_many :outgoing_targets

    validates :identifier, presence: true, uniqueness: true
    validates :endpoint, presence: true, uniqueness: true
    validates :api_key, presence: true

    def human
      "#{identifier} | #{endpoint}"
    end
  end
end
