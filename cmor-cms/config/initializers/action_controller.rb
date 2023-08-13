Rails.application.config.to_prepare do
  print "[Cmor::Cms] Adding textile template handler"
  ActionController::Renderers.add :textile do |text, options|
    RedCloth.new(text).to_html.html_safe
  end
  puts " =>[OK]"
end
