namespace :cmor do
  namespace :tags do
    desc 'Searches for things by tags'
    task :tag_search, [:tag_list, :exact] => [:environment] do |_t, args|
      Cmor::Tags::TagSearch.call(args)
    end
  end
end
