module Cmor::Contact
  class ContactRequestMailer < ApplicationMailer

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.contact_request_mailer.notify.subject
    #
    def notify(contact_request)
      @contact_request = contact_request

      mail to: notification_recipients,
           from: notification_sender(contact_request),
           subject: notification_subject
    end

    private

    def notification_subject
      default_i18n_subject(application_name: Rails.application.class.to_s.split('::').first.underscore.humanize.titleize)
    end

    def notification_sender(contact_request)
      Cmor::Contact::Configuration.sender.call(contact_request)
      # "#{contact_request.name} <#{contact_request.email}>"
    end

    def notification_recipients
      ENV.fetch('CMOR_CONTACT_RECIPIENTS') { Cmor::Contact::Configuration.recipients.call(Rails.env) }
    end
  end
end
