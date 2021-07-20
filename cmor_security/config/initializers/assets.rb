Rails.application.config.assets.precompile += %w( cmor_security/manifest.js )

# This should not be needed. But deleting it breaks feature specs.
Rails.application.config.assets.precompile += %w( cmor_security.css cmor_security.js )
