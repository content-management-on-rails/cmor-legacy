module Cmor::Contact
  class ContactRequest < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :ip_address, presence: true
    validates :message, presence: true
    validates :accept_terms_of_service, acceptance: true

    module SpamProtection
      attr_accessor :nickname

      def save
        if nickname.present?
          valid?
          return true
        else
          super
        end
      end
    end

    module Notification
      def self.included(base)
        base.after_save :notify, if: -> { notified_at.nil? }
      end

      def notify
        NotifyNewContactRequestJob.perform_later(id)
      end
    end

    prepend SpamProtection
    include Notification
  end
end
