module Cmor::Audits
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Audits

    config.to_prepare do
      ActionDispatch::Routing::Mapper.send(:include, Cmor::Audits::Routing::PaperTrailResourcesConcern)

      Cmor::Audits::Configuration.resources.call.each do |resource_class, options|
        puts "[Cmor::Audits] Enabling paper trail on #{resource_class}"
        resource_class.constantize.send(:has_paper_trail, options)
      end
    end
  end
end
