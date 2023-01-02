Cmor::Contact.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::Contact::ContactRequestsController
  #          ]}
  #
  config.resources_controllers = lambda {
    [
      Cmor::Contact::ContactRequestsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[
  #          ]}
  #
  config.service_controllers = lambda {
    []
  }

  # Configure your contact request sender here.
  #
  # Default:
  #
  # config.sender = lambda do |contact_request|
  #   "#{contact_request.name} <#{contact_request.email}>"
  # end
  #
  # You may want to reconfigure this to use a static email address from
  # your domain to avoid being marked as spammer when contact requests
  # are sent from invalid addresses.
  #
  # Example with environment specific configuration:
  #
  #     config.sender = lambda do |contact_request|
  #       {
  #         development: %w( no-reply@domain.local ),
  #         test:        %w( no-reply@domain.local ),
  #         production:  %w( no-reply@domain.local )
  #       }.with_indifferent_access[environment.to_sym]
  #     end
  #
  # Default:
  #
  # config.sender = -> (contact_request) { ENV.fetch("CMOR_CONTACT_SENDER", "no-reply@domain.local") }
  #
  config.sender = ->(contact_request) { ENV.fetch("CMOR_CONTACT_SENDER", "no-reply@domain.local") }

  # Configure your contact request recipients here.
  #
  # You can specify multiple recipients and multiple environments.
  #
  # Example with environment specific configuration:
  #
  #     config.recipients = lambda do |contact_request|
  #       {
  #         development: %w( info@domain.local ),
  #         test:        %w( info@domain.local ),
  #         production:  %w( info@domain.local )
  #       }.with_indifferent_access[environment.to_sym]
  #     end
  #
  # Default:
  #
  # config.recipients = -> (contact_request) { ENV.fetch("CMOR_CONTACT_RECIPIENTS", "info@domain.local").split(",") }
  #
  config.recipients = ->(contact_request) { ENV.fetch("CMOR_CONTACT_RECIPIENTS", "info@domain.local").split(",") }

  # Modules listed here will be included in Cmor::Contact::ContactRequest.
  #
  # Available modules are:
  #
  # - Cmor::Contact::ContactRequest::PhoneConcern
  # - Cmor::Contact::ContactRequest::SubjectConcern
  #
  # Default: config.contact_request_include_modules = ->() { [Cmor::Contact::ContactRequest::PhoneConcern] }
  #
  config.contact_request_include_modules = -> { [Cmor::Contact::ContactRequest::PhoneConcern] }

  # Set the whatsapp number for the whatsapp contact widget.
  #
  # Example: config.default_whatsapp_number = "+49 123 4567890"
  #
  # Default: config.whatsapp_number = nil
  #
  config.whatsapp_number = nil
end
