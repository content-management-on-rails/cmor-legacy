Cmor::Cms.configure do |config|
  # Set the default handler for pages, partials and templates
  #
  # Default:   config.default_handlers = {
  #              page:     :textile,
  #              partial:  :textile,
  #              template: :textile
  #            }
  #
  config.default_handlers = {
    page:     :textile,
    partial:  :textile,
    template: :textile
  }

  # Set the base controller for the page controller
  #
  # Default: config.base_controller = 'ApplicationController'
  #
  config.base_controller = 'ApplicationController'

  # Set the property keys for navigation items. This keys will be accessible through the create/edit form.
  #
  # Example: You configured vaigation_item_properties like this:
  #
  #     config.navigation_item_properties = [:data_add_icon]
  #
  #  Then you created a navigation item with data_add_icon = 'earphone'.
  #
  # The li-element will be rendered like this:
  #
  #     <li id="contact" data_add_icon="earphone">
  #
  # Default: config.navigation_item_properties = [:data_add_icon]
  #
  config.navigation_item_properties = [:data_add_icon]

  # Fallback to the given locale, if no navigation is found for the actual locale.
  # Set to false to disable fallback. Must be a proc. Two params are passend to the
  # proc: The navigation name and the actual locale.
  # 
  # Example: config.navigation_locale_fallback = ->(navigation_name, locale) { navigation_name, localeI18n.locale }
  # 
  # Default: config.navigation_locale_fallback = ->(navigation_name, locale) { false }
  # 
  config.navigation_locale_fallback = ->(navigation_name, locale) { I18n.default_locale }
end
