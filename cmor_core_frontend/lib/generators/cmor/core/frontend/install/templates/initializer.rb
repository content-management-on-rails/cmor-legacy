Cmor::Core::Frontend.configure do |config|
  # Methods, that will be tried on a resource to generate a nice title
  #
  # Default: config.resource_label_methods = %i(human name email to_s)
  #
  config.resource_label_methods = %i(human name email to_s)

  # Sets the first breadcrumb. This is usually the home link.
  #
  # Default: config.first_breadcrumb = ->() { Cmor::Core::Frontend::Breadcrumb::Base.new(label: t('.home'), url: c.main_app.root_path) }
  #
  config.first_breadcrumb = ->() { Cmor::Core::Frontend::Breadcrumb::Base.new(label: t('.home'), url: c.main_app.root_path) }
end