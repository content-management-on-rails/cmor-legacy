Cmor::Contact.configure do |config|  
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::Contact::ContactRequestsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::Contact::ContactRequestsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}

  # Configure your contact request recipients here.
  #
  # You can specify multiple recipients and multiple environments.
  #
  # Default:
  #
  # config.recipients = lambda do |environment|
  #   {
  #     development: %w( info@development.example.com ),
  #     test:        %w( info@test.example.com ),
  #     production:  %w( info@production.example.com )
  #   }.with_indifferent_access[environment.to_sym]
  # end
  #
  config.recipients = lambda do |environment|
    {
      development: %w( info@development.example.com ),
      test:        %w( info@test.example.com ),
      production:  %w( info@production.example.com )
    }.with_indifferent_access[environment.to_sym]
  end

  # Set the sender address.
  # 
  # default: config.sender = ->(mail_form) { %("#{mail_form.name}" <#{mail_form.email}>) }
  # 
  config.sender = ->(mail_form) { %("#{mail_form.name}" <#{mail_form.email}>) }

  # Modules listed here will be included in Cmor::Contact::ContactRequest.
  #
  # Available modules are:
  #
  # - Cmor::Contact::ContactRequest::PhoneConcern
  # - Cmor::Contact::ContactRequest::SubjectConcern
  #
  # Default: config.contact_request_include_modules = ->() { [Cmor::Contact::ContactRequest::PhoneConcern] }
  #
  config.contact_request_include_modules = ->() { [Cmor::Contact::ContactRequest::PhoneConcern] }

  # Set the whatsapp number for the whatsapp contact widget.
  #
  # Example: config.default_whatsapp_number = "+49 123 4567890"
  #
  # Default: config.whatsapp_number = nil
  #
  config.whatsapp_number = nil
end