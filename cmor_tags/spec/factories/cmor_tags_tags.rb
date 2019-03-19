FactoryBot.define do
  factory :cmor_tags_tag, class: Cmor::Tags::Tag do
    sequence(:name) { |i| "tag-name-#{i}" }
  end
end

