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
end
