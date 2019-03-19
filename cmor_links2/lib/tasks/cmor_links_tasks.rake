namespace :cmor_links do
  namespace :db do
    desc 'Purges and creates example data'
    task :populate!, [] => [:environment] do |_t, _args|
      Rake::Task['cmor_links:db:clear!'].execute
      Rake::Task['cmor_links:db:populate'].execute
    end

    desc 'Clears all data!'
    task :clear!, [] => [:environment] do |_t, _args|
      Cmor::Links::Category.delete_all
      Cmor::Links::Link.delete_all
    end

    desc 'Creates example_data'
    task :populate, [] => [:environment] do |_t, _args|
      require 'ffaker'
      require 'forgery'

      # Create example categories
      5.times do
        Cmor::Links::Category.create! do |c|
          c.locale = I18n.available_locales.map(&:to_s).choice
          c.name = "#{Faker::Company.name} Category"
          c.link_footer_column = [nil, 1, 2, 3, 4].choice
        end
      end

      50.times do
        Cmor::Links::Category.create! do |c|
          c.parent = Cmor::Links::Category.all.choice
          c.name = "#{Faker::Company.name} Category"
          c.link_footer_column = [nil, 1, 2, 3, 4].choice
        end
      end

      # Create example links
      categories = Cmor::Links::Category.all
      50.times do
        Cmor::Links::Link.create! do |l|
          l.name = "#{Faker::Company.name} Link"
          l.url = "#{Faker::Internet.http_url} Link"
          l.description = Faker::Lorem.paragraph(rand(3))
          l.cmor_links_category = categories.choice
        end
      end
    end
  end
end
