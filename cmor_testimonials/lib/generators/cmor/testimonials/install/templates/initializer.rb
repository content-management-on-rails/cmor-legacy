Cmor::Testimonials.configure do |config|
  # Set image variant options.
  #
  # default: config.image_variant_options = {
  #            category: { combine_options: { resize: "150x150^", gravity: 'center', crop: "150x150+0+0" } }
  #          }
  config.image_variant_options = {
    category: { combine_options: { resize: "150x150^", gravity: 'center', crop: "150x150+0+0" } }
  }
end
