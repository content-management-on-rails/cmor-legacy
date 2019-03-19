module Cmor::Contact
  class NotifyNewContactRequestJob < ApplicationJob
    queue_as :contact_requests

    def perform(contact_request_id)
      load_contact_request(contact_request_id)
      deliver
      mark_as_notified
    end

    private

    def load_contact_request(id)
      @contact_request = ContactRequest.find(id)
    end

    def deliver
      ContactRequestMailer.notify(@contact_request).deliver_now
    end

    def mark_as_notified
      @contact_request.update(notified_at: Time.zone.now)
    end
  end
end
