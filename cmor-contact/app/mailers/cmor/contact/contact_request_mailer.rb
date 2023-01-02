module Cmor::Contact
  class ContactRequestMailer < ApplicationMailer
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.cmor.cmor_contact.contact_request_mailer.notify.subject
    #
    def notify(contact_request)
      @contact_request = contact_request

      mail to: notification_recipients,
        from: notification_sender,
        subject: notification_subject
    end

    private

    def notification_subject
      default_i18n_subject(application_name: Rails.application.class.to_s.split("::").first.underscore.humanize.titleize)
    end

    def notification_sender
      Cmor::Contact::Configuration.sender.call(@contact_request)
    end

    def notification_recipients
      Cmor::Contact::Configuration.recipients.call(@contact_request)
    end
  end
end
