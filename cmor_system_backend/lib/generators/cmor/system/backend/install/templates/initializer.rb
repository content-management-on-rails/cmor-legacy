Cmor::System::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::System::Backend::DelayedBackendActiveRecordJobsController,
  #            Cmor::System::Backend::ActiveStorage::BlobsController,
  #            Cmor::System::Backend::ActiveStorage::AttachmentsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::System::Backend::DelayedBackendActiveRecordJobsController,
    Cmor::System::Backend::ActiveStorage::BlobsController,
    Cmor::System::Backend::ActiveStorage::AttachmentsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}

  # Factory name to use for creators and updaters.
  #
  # default: config.record_factory_name = 'post'
  #
  config.record_factory_name = '<%= record_factory_name %>'

  # Enable support for ActiveStorage.
  # 
  # default: config.enable_active_storage_backend = false
  # 
  config.enable_active_storage_backend = <%= cmor_system_backend_enable_active_storage %>

  # Enable support for DelayedJob.
  #
  # default: config.enable_delayed_job_backend = false
  #
  config.enable_delayed_job_backend = <%= cmor_system_backend_enable_delayed_job %>
end