module Cmor::Transports
  class Outgoing < ApplicationRecord
    include AASM

    belongs_to :creator, optional: true
    has_many :outgoing_exports
    has_many :outgoing_targets

    validates :state, presence: true

    aasm(:default, column: 'state') do
      state :created, initial: true
      state :enqueued
      state :processing
      state :failed
      state :succeeded

      event :enqueue, after: :enqueue_service_call do
        transitions from: [:created, :enqueued], to: :processing
      end

      event :process do
        transitions from: :enqueued, to: :processing
      end

      event :fail do
        transitions from: :processing, to: :failed
      end

      event :succeed do
        transitions from: :processing, to: :succeeded
      end
    end
  end
end
