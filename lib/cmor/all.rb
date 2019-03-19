require "cmor"
 
%w(
  cmor_blog
  cmor_blog_backend
  cmor_carousels
  cmor_carousels_backend
  cmor_cms2
  cmor_cms2_backend
  cmor_contact2
  cmor_contact2_backend
  cmor_files
  cmor_files_backend
  cmor_galleries
  cmor_galleries_backend
  cmor_links2
  cmor_links2_backend
  cmor_rbac
  cmor_rbac_backend
  cmor_tags
  cmor_tags_backend
  cmor_user_area2
  cmor_user_area2_backend
).each do |engine|
  begin
    require engine
  rescue LoadError
  end
end