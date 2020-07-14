module Cmor::Transports
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Transports

    config.to_prepare do
      print "[Cmor::Transports] Adding resources routes"
      Cmor::Core::Backend.configure do |config|
        config.add_resources_routes(
          :cmor_transports,
          condition: -> { controller_class.ancestors.map(&:to_s).include?("Cmor::Transports::ResourcesController::ExportConcern") },
          routes:    -> { export_resources }
        )
      end
      puts " => [OK]"
    end
  end
end
