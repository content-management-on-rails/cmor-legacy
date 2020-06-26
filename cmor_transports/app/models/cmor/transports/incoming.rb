module Cmor::Transports
  class Incoming < ApplicationRecord
    include Cmor::Transports::Models::UuidConcern
    include AASM

    belongs_to :creator, optional: true, polymorphic: true
    # belongs_to :job, optional: true

    has_one_attached :input
    has_one_attached :payload

    validates :outgoing_uuid, presence: true, uniqueness: true

    aasm(:default, column: 'state') do
      state :created, initial: true
      state :enqueued
      state :processing
      state :failed
      state :succeeded

      event :enqueue, after: :enqueue_service_call do
        transitions from: :created, to: :enqueued
      end

      event :process do
        transitions from: [:created, :enqueued], to: :processing
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
