$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_frontend/lib/cmor/core/frontend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Frontend::Gemspec.defaults(s)
  s.name        = "cmor_suite"
  s.summary     = "Easy Content Management Suite."
  s.description = "Modular, scalable content management on rails."

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # I don't know why we need this all of a sudden
  s.add_development_dependency 'sassc-rails'
  # This seems to be needed when using rails >= 5.2.3
  s.add_development_dependency "bootsnap"
  s.add_development_dependency "turbolinks", "~> 5"

  s.add_dependency 'cmor_blog', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_blog_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_carousels', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_carousels_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_cms', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_cms_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_contact', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_contact_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_files', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_files_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_galleries', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_galleries_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_links', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_links_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_partners', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_partners_frontend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_rbac', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_rbac_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_seo', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_seo_frontend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_showcase', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_showcase_frontend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_system_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_tags', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_tags_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_testimonials', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_testimonials_backend', "= #{Cmor::VERSION}"

  s.add_dependency 'cmor_user_area', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_user_area_backend', "= #{Cmor::VERSION}"
end
