FactoryBot.define do
  factory :cmor_partners_partner, class: Cmor::Partners::Partner do
    association(:category, factory: :cmor_partners_category)
    sequence(:name) { |i| "Partner ##{i}" }
  end
end
