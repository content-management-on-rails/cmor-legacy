module Cmor::Transports
  class OutgoingTarget < ApplicationRecord
    belongs_to :outgoing
    belongs_to :system
  end
end
