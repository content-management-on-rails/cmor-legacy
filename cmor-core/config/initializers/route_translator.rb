Rails.application.config.to_prepare do
  print "[Cmor::Core] Adding #set_locale_from_url as around action on ::ApplicationController"
  ::ApplicationController.send(:around_action, :set_locale_from_url)
  puts " => [OK]"
end
