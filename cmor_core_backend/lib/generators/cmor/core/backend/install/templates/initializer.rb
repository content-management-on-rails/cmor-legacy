Cmor::Core::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::Core::Backend::DelayedJobsController,
  #            Cmor::Core::Backend::ActiveStorage::BlobsController,
  #            Cmor::Core::Backend::ActiveStorage::AttachmentsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::Core::Backend::DelayedJobsController,
    Cmor::Core::Backend::ActiveStorage::BlobsController,
    Cmor::Core::Backend::ActiveStorage::AttachmentsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}

  # Enable support for ActiveStorage.
  # 
  # default: config.enable_active_storage_backend = false
  # 
  config.enable_active_storage_backend = false

  # Enable support for DelayedJob.
  #
  # default: config.enable_delayed_job_backend = false
  #
  config.enable_delayed_job_backend = false
end