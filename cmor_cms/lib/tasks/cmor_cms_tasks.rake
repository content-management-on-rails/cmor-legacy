namespace :cmor do
  namespace :cms do
    desc 'Imports partials from app/views into the database'
    task :import_partials, [:view_path, :force] => [:environment] do |_t, args|
      args.with_defaults(view_path: Rails.root.join(*%(app views)), force: false)
      Cmor::Cms::ImportPartialsService.call(args)
    end

    desc 'Adds homepages for all (or given) locales (Specify locales like this: rails cmor:cms:add_homepages["en de"])'
    task :add_homepages, [:locales] => [:environment] do |_t, args|
      args.with_defaults(locales: I18n.available_locales)
      options = args.to_h
      if options[:locales].is_a?(String)
        options[:locales] = options[:locales].split.map(&:to_sym) & I18n.available_locales
      end

      Cmor::Cms::AddHomepagesService.call(options)
    end
  end
end
