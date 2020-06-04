module Cmor::Transports
  class Export < ApplicationRecord
    include AASM

    belongs_to :creator, polymorphic: true
    # belongs_to :job, optional: true
    has_one_attached :output

    aasm(:default, column: 'state') do
      state :created, initial: true
      state :enqueued
      state :processing
      state :failed
      state :succeeded

      event :enqueue do
        transitions from: :created, to: :enqueued, before: :enqueue
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

    def enqueue
      result = export_service_class_name.constantize.call_later!(export: self)
      self.job_id = result.job_id
      binding.pry
    end

    # def enqueue
    #   result = export_service_class_name.constantize.call!(export: self)
    # end

    def export_service_class_name
      "Cmor::Transports::Exports::#{self.output_format.camelize}Service"
    end
  end
end
