module Cmor::MultiTenancy
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::MultiTenancy

    # inject client concern into scoped models. Do this as late as poosible
    # to make sure all scoped models are loaded.
    # config.after_initialize do
    config.to_prepare do
      puts "[Cmor::MultiTenancy] Injecting client concern into scoped models:"
      Cmor::MultiTenancy::Configuration.scoped_models.call.each do |model, options|
        p "[Cmor::MultiTenancy]   #{model}"
        model.class_eval do
          include Cmor::MultiTenancy::Model::ClientConcern
        end
        puts "[Cmor::MultiTenancy]     => OK"
      end

      puts "[Cmor::MultiTenancy] Adding scoped model associations to the client model:"
      Cmor::MultiTenancy::Configuration.scoped_models.call.each do |model, options|
        p "[Cmor::MultiTenancy]   #{model}"
        Cmor::MultiTenancy::Client.class_eval do
          has_many model.to_s.tableize.gsub("/", "_").to_sym, class_name: model.to_s, dependent: :destroy
        end
        puts "[Cmor::MultiTenancy]     => OK"
      end
    end
  end
end
