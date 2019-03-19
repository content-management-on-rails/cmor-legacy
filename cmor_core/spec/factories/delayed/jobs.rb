FactoryBot.define do
  factory :delayed_job, class: 'Delayed::Job' do
    handler 'handler'
  end
end
