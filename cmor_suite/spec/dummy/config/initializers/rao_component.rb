Rao::Component.configure do |config|
  # Set the default format for timestamps in tables.
  #
  # Default: config.table_default_timestamp_format = nil
  #
  config.table_default_timestamp_format = :short_with_year

  # Set the default format for dates in tables.
  #
  # Default: config.table_default_date_format = nil
  #
  config.table_default_date_format = :short_with_year

  # Set the default format for dates in tables.
  #
  # Default: config.table_default_date_format = nil
  #
  config.table_default_date_format = :short_with_year

  # Image variant options for images in tables
  #
  # default: 
  #
  #     config.image_variant_options = {
  #       collection: { resize: "160x120" },
  #       resource:   { resize: "320x240" }
  #     }
  #
  config.image_variant_options = {
    collection: { resize: "160x120" },
    resource:   { resize: "320x240" }
  }
end
