Cmor::Contact::Frontend.configure do |config|
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
end
