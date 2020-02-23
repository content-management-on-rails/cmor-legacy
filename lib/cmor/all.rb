require "cmor"
 
%w(
  cmor_blog
  cmor_blog_backend
  cmor_carousels
  cmor_carousels_backend
  cmor_cms
  cmor_cms_backend
  cmor_contact
  cmor_contact_backend
  cmor_files
  cmor_files_backend
  cmor_galleries
  cmor_galleries_backend
  cmor_legal
  cmor_legal_backend_frontend
  cmor_links
  cmor_links_backend
  cmor_partners
  cmor_partners_frontend
  cmor_rbac
  cmor_rbac_backend
  cmor_seo
  cmor_seo_frontend
  cmor_showcase
  cmor_showcase_frontend
  cmor_tags
  cmor_tags_backend
  cmor_testimonials
  cmor_testimonials_backend
  cmor_user_area
  cmor_user_area_backend
).each do |engine|
  begin
    require engine
  rescue LoadError
  end
end