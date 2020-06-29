# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_transports_export, class: Cmor::Transports::Export do
    root_model { Cmor::Transports::Configuration.factory_root_model_class_name.constantize.name }
    query { Cmor::Transports::Configuration.factory_root_model_class_name.constantize.all.to_sql }
    count_query { Cmor::Transports::Configuration.factory_root_model_class_name.constantize.select(Arel.star.count).to_sql }
    output_attributes { Cmor::Transports::Configuration.factory_root_model_class_name.constantize.attribute_names }
    output_format { :csv }
  end
end
