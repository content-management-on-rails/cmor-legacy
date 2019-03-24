FactoryBot.define do
  factory :delayed_backend_active_record_job, class: 'Delayed::Backend::ActiveRecord::Job' do
    handler { 'handler' }
  end
end
