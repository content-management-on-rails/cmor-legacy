module Cmor::Audits
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Audits

    config.to_prepare do
      ActionDispatch::Routing::Mapper.send(:include, Cmor::Audits::Routing::PaperTrailResourcesConcern)
      Cmor::Core::Backend::ResourcesController::Base.send(:include, Cmor::Audits::ResourcesController::PaperTrailConcern)

      Cmor::Audits::Configuration.resources.call.each do |resource_class, options|
        puts "[Cmor::Audits] Enabling paper trail on #{resource_class}"
        resource_class.constantize.send(:has_paper_trail, options)
      end

      Cmor::Core::Backend.configure do |config|
        config.add_resources_routes(
          :cmor_audits,
          condition: ->{ resource_class.ancestors.map(&:to_s).include?("PaperTrail::Model::InstanceMethods") },
          routes:    ->{ paper_trail_resources }
        )
      end
    end
  end
end
