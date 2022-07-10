module Cmor
  module Security
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Security

      config.to_prepare do
        Configuration.antivirus_enabled_models.each do |av_config|
          puts "[Cmor::Security] Enabling tatoru.io antivirus for #{av_config.model_class_name}##{av_config.attachment_name}..."
          av_config.model_class_name.constantize.send(:validates, av_config.attachment_name, tatoru: true, **av_config.options)
          puts "  => OK"
        rescue NameError => e
          puts "  => Failed: #{e.message}"
          next
        end
      end
    end
  end
end
