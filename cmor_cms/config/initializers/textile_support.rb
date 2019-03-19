Rails.application.config.to_prepare do
  ::ActionView::Template.register_template_handler :textile, ::ActionView::Template::Handlers::Textile.new
end