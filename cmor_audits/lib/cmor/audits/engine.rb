# frozen_string_literal: true

module Cmor::Audits
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Audits

    config.to_prepare do
      print "[Cmor::Audits] Including Cmor::Audits::Routing::PaperTrailResourcesConcern into ActionDispatch::Routing::Mapper"
      ActionDispatch::Routing::Mapper.send(:include, Cmor::Audits::Routing::PaperTrailResourcesConcern)
      puts " => [OK]"

      Cmor::Audits::Configuration.resources.call.each do |resource_class, options|
        print "[Cmor::Audits] Enabling paper trail on #{resource_class}"
        resource_class.constantize.send(:has_paper_trail, options)
        puts " => [OK]"
      end

      print "[Cmor::Audits] Adding resources routes"
      Cmor::Core::Backend.configure do |config|
        config.add_resources_routes(
          :cmor_audits,
          condition: -> { PaperTrail.request.enabled_for_model?(resource_class) },
          routes:    -> { paper_trail_resources }
        )
      end
      puts " => [OK]"

      unless Rails.application.config.instance_variable_get(:@eager_load)
        print "[Cmor::Audits] Reloading routes"
        Rails.application.reload_routes!
        puts " => [OK)"
      end
    end
  end
end
