# frozen_string_literal: true

module Cmor::Transports
  class Outgoing < ApplicationRecord
    include Cmor::Transports::Models::UuidConcern
    include AASM

    belongs_to :creator, optional: true, polymorphic: true

    has_many :outgoing_exports, dependent: :destroy
    has_many :exports, through: :outgoing_exports

    has_many :outgoing_targets, dependent: :destroy
    has_many :systems, through: :outgoing_targets

    has_one_attached :output

    validates :state, presence: true

    aasm(:default, column: "state") do
      state :created, initial: true
      state :enqueued_for_pack
      state :packing
      state :failed_packing
      state :succeeded_packing
      state :enqueued_for_transfer
      state :transferring
      state :failed_transferring
      state :succeeded_transferring

      event :enqueue_packing, after: :enqueue_packing_service_call do
        transitions from: :created, to: :enqueued_for_pack
      end

      event :start_packing do
        transitions from: :enqueued_for_pack, to: :packing
      end

      event :failed_packing do
        transitions from: :packing, to: :failed_packing
      end

      event :succeed_packing do
        transitions from: :packing, to: :succeeded_packing
      end

      event :reset_packing do
        transitions from: [:enqueued_for_packing, :failed_packing], to: :created
      end

      event :enqueue_for_transfer, after: :enqueue_transferring_service_call do
        transitions from: :succeeded_packing, to: :enqueued_for_transfer
      end

      event :start_transferring do
        transitions from: :enqueued_for_transfer, to: :transferring
      end

      event :failed_transferring do
        transitions from: :transferring, to: :failed_transferring
      end

      event :reset_transferring do
        transitions from: [:enqueued_for_transfer, :failed_transferring], to: :succeeded_packing
      end

      event :succeed_transferring do
        transitions from: :transferring, to: :succeeded_transferring
      end
    end

    def enqueue_packing_service_call
      result = pack_service_class_name.constantize.call_later!(outgoing: self)
      self.job_id = result.job_id
    end

    def enqueue_transferring_service_call
      result = transfer_service_class_name.constantize.call_later!(outgoing: self)
      self.job_id = result.job_id
    end

    def pack_service_class_name
      "Cmor::Transports::Packs::ZipService"
    end

    def transfer_service_class_name
      "Cmor::Transports::Transfers::Api::PushService"
    end

    def output_base64
      if output.attached?
        Base64.encode64(output.attachment.blob.download)
      else
        nil
      end
    end
  end
end
