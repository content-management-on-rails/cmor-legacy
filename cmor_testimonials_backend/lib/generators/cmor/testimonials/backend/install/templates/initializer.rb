Cmor::Testimonials::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.registered_resources = -> {[
  #            Cmor::Testimonials::Backend::CategoriesController,
  #            Cmor::Testimonials::Backend::TestimonialsController
  #          ]}
  #
  config.registered_resources = lambda {
    [
      Cmor::Testimonials::Backend::CategoriesController,
      Cmor::Testimonials::Backend::TestimonialsController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.registered_services = -> {[]}
  #
  config.registered_services = -> { [] }
end
