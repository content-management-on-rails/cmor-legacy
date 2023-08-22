Rails.application.config.assets.precompile += %w( <%= flat_path %>.css )
Rails.application.config.assets.precompile += %w( <%= flat_path %>.js )