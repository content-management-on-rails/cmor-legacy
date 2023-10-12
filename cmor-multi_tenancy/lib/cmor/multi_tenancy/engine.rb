module Cmor::MultiTenancy
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::MultiTenancy

    # inject client concern into scoped models. Do this as late as poosible
    # to make sure all scoped models are loaded.
    # config.after_initialize do
    config.to_prepare do
      begin
        ActiveRecord::Base.connection
      rescue => e
        puts "[Cmor::MultiTenancy] Skipping client concern injection because database does not exist yet (#{e.message})."
        next
      end

      puts "[Cmor::MultiTenancy] Injecting client concern into scoped models:"
      Cmor::MultiTenancy::Configuration.scoped_models.call.each do |model, options|
        print "[Cmor::MultiTenancy]   #{model}"
        model.class_eval do
          include Cmor::MultiTenancy::Model::ClientConcern
        end
        puts " => OK"
      end

      puts "[Cmor::MultiTenancy] Adding scoped model associations to the client model:"
      Cmor::MultiTenancy::Configuration.scoped_models.call.each do |model, options|
        print "[Cmor::MultiTenancy]   #{model}"
        Cmor::MultiTenancy::Client.class_eval do
          has_many model.to_s.tableize.tr("/", "_").to_sym, class_name: model.to_s, dependent: :destroy
        end
        puts " => OK"
      end
    end
  end
end
