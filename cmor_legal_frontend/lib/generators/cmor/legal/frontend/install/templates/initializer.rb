Cmor::Legal::Frontend.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Set the css class for the cookie consent banner modal.
  #
  # Default: config.cookies_consent_banner_modal_class = 'modal fade cookies-eu js-cookies-eu'
  #
  config.cookies_consent_banner_modal_class = 'modal fade cookies-eu js-cookies-eu'

  # Set the css class for the cookie consent banner modal dialog.
  #
  # Default: config.cookies_consent_banner_modal_dialog_class = 'modal-lg modal-dialog'
  #
  config.cookies_consent_banner_modal_dialog_class = 'modal-lg modal-dialog'
end
