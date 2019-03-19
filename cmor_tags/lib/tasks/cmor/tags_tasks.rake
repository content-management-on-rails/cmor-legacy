namespace :cmor do
  namespace :tags do
    desc 'Searches for things by tags'
    task :tag_search, [:tag_list, :fuzzy] => [:environment] do |_t, args|
      Tenant.set_current_by_identifier ENV['TENANT']
      Cmor::Tags::TagSearch.call(args)
    end
  end
end
