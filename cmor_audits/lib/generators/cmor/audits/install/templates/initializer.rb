Cmor::Audits.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[
  #   Cmor::Audits::PaperTrail::VersionsController,
  # ]}
  # 
  config.resources_controllers = -> {[
    Cmor::Audits::PaperTrail::VersionsController,
  ]}

  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resource_controllers = -> {[]}
  # 
  config.resource_controllers = -> {[]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.service_controllers = -> {[]}
  # 
  config.service_controllers = -> {[]}

  # Set the sidebars, that will be shown in the backend menu.
  # 
  # Default: config.sidebar_controllers = -> {[]}
  # 
  config.sidebar_controllers = -> {[]}

  # Factory name to use for audited objects.
  #
  # Default: config.audited_factory_name = <%= audited_factory_name %>
  #
  config.audited_factory_name = <%= audited_factory_name %>

  # Class name of the change creator model.
  #
  # Default: config.whodunnit_class_name = "<%= whodunnit_class_name %>"
  #
  config.whodunnit_class_name = "<%= whodunnit_class_name %>"

  # Proc to find the change creator model.
  #
  # Default: config.whodunnit_find_proc = <%= whodunnit_find_proc %>
  #
  config.whodunnit_find_proc = <%= whodunnit_find_proc %>

  # Specify the models that will be audited. Listing models here is the same
  # as adding has_paper_trail to the model class directly.
  #
  # Example: config.resources = -> {
  #            {
  #              "Cmor::Cms::Page" => {}
  #            }
  #          }
  #
  # Options:
  #
  # paper_trail: The paper_trail hash is passed to has_paper_trail as options hash.
  #
  # Example: config.resources = -> {
  #            {
  #              "Post" => { paper_trail: { on: [:update] }
  #            }
  #          }
  #
  # link_to_version: If you need a custom link to the specific version of a
  # resource, you can override the url generation here:
  #
  # Example:
  #
  #     config.resources = -> {
  #       {
  #         "ActiveStorage::Blob" => { link_to_version: ->(resource) { cmor_system.polymorphic_path([:version, :active_storage, resource.reify], version_id: resource.id) } }
  #       }
  #     }
  #
  # Default: config.resources = -> {{}}
  #
  config.resources = -> { {} }
end
