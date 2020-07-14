# frozen_string_literal: true

module Cmor::Transports
  class OutgoingExport < ApplicationRecord
    belongs_to :outgoing
    belongs_to :export
  end
end
