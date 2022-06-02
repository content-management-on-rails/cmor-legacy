# frozen_string_literal: true

namespace :cmor do
  namespace :seo do
    desc "Explaining what the task does"
    task :generate_all, [:resource_classes] => [:environment] do |task, args|
      args.with_defaults(resource_classes: Cmor::Seo::Configuration.resources.keys)
      puts args
      Cmor::Seo::GenerateResourceClassesMetaTagsService.call!(resource_classes: args[:resource_classes])
    end
  end
end
