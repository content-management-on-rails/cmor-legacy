Cmor::Core::Backend.configure do |config|
  # Globally set variant options to be used in backends.
  #
  # default: config.image_variant_options = {
  #            gallery: { resize: "640x480" },
  #            table:   { resize: "160x120" }
  #          }
  config.image_variant_options = {
    gallery: { resize: "640x480" },
    table:   { resize: "160x120" }
  }
end