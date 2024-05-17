Cmor::Contact.configure do |config|
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
  # Example:
  #
  # config.sender = lambda do |contact_request|
  #   "My Application <contact@example.com>"
  # end
  #
  config.sender = lambda do |contact_request|
    "#{contact_request.name} <#{contact_request.email}>"
  end

  # Configure your input field css classes here.
  #
  # Default: config.input_name_css_classes = 'form-control'
  #
  config.input_name_css_classes = 'form-control'

  # Configure your input field css classes here.
  #
  # Default: config.input_email_css_classes = 'form-control'
  #
  config.input_email_css_classes = 'form-control'

  # Configure your input field css classes here.
  #
  # Default: config.input_phone_css_classes = 'form-control'
  #
  config.input_phone_css_classes = 'form-control'

  # Configure your input field css classes here.
  #
  # Default: config.input_message_css_classes = 'form-control'
  #
  config.input_message_css_classes = 'form-control'

  # Configure your input field css classes here.
  #
  # Default: config.input_terms_of_service_css_classes = 'form-control'
  #
  config.input_terms_of_service_css_classes = ''

  # Configure your form action wrapper div css classes here.
  #
  # Default: config.form_actions_wrapper_css_classes = 'controls form-actions well'
  #
  config.form_actions_wrapper_css_classes = 'controls form-actions well'

  # set the base controller for the contact form
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Add additional information to the contact form. This will be printed
  # between the heading and the form. You should provide a proc, or
  # an object, that reponds to #call. The view ist provided as parameter.
  #
  # Example: config.additional_contact_information = lambda { |view| view.render 'additional_contact_information' }
  #
  # Default: config.additional_contact_information = nil
  #
  config.additional_contact_information = nil

  # url to redirect to after successful contact request.
  # 
  # default: config.after_create_url = ->(controller) { controller.root_path }
  # 
  config.after_create_url = ->(controller) { controller.root_path }

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

  # Configure the spam protection method.
  #
  # Available options are:
  #
  # - :hidden_field
  # - :google_recaptcha_v2
  # - :google_recaptcha_v3
  #
  # To use google recaptcha v3 you need to add the recaptcha gem to your Gemfile:
  #
  #     # Gemfile
  #     gem 'recaptcha'
  #
  # Default: config.spam_protection = :hidden_field
  #
  config.spam_protection = :hidden_field
end
