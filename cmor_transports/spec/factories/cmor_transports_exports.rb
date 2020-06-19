# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_export, class: Cmor::Transports::Export do
    root_model { Post.name }
    query { Post.all.to_sql }
    output_format { :csv }
  end
end
