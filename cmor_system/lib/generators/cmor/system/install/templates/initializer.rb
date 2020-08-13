Cmor::System.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #            Cmor::System::DelayedBackendActiveRecordJobsController,
  #            Cmor::System::ActiveStorage::BlobsController,
  #            Cmor::System::ActiveStorage::AttachmentsController
  #          ]}
  # 
  config.registered_controllers = -> {[
    Cmor::System::DelayedBackendActiveRecordJobsController,
    Cmor::System::ActiveStorage::BlobsController,
    Cmor::System::ActiveStorage::AttachmentsController
  ]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.registered_services = -> {[
  #          ]}
  # 
  config.registered_services = -> {[
  ]}

  # Factory name to use for active storage attachment records.
  #
  # default: config.record_factory_name = 'post'
  #
  config.record_factory_name = '<%= record_factory_name %>'

  # Attachment name to use for active storage attachments.
  #
  # default: config.record_attachment_name = 'asset'
  #
  config.record_attachment_name = '<%= record_attachment_name %>'

  # Enable support for ActiveStorage.
  # 
  # default: config.enable_active_storage_backend = false
  # 
  config.enable_active_storage_backend = <%= cmor_system_enable_active_storage %>

  # Enable support for DelayedJob.
  #
  # default: config.enable_delayed_job_backend = false
  #
  config.enable_delayed_job_backend = <%= cmor_system_enable_delayed_job %>
end