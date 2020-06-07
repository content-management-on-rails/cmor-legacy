module Cmor::Transports
  class Export < ApplicationRecord
    include AASM

    belongs_to :creator, optional: true, polymorphic: true
    # belongs_to :job, optional: true
    has_many :outgoing_exports
    has_one_attached :output

    validates :root_model, presence: true
    validates :query, presence: true

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

    def enqueue_service_call
      result = export_service_class_name.constantize.call_later!(export: self)
      self.job_id = result.job_id
    end

    def export_service_class_name
      "Cmor::Transports::Exports::#{self.output_format.camelize}Service"
    end
  end
end