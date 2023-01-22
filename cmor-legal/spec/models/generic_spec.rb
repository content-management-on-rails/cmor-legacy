require "rails_helper"

RSpec.describe "ActiveRecord::Base models", type: :model do
  # rubocop:disable Lint/ConstantDefinitionInBlock
  DEFAULT_SPECS_TO_RUN = [
    :is_an_active_record,
    :is_instanciable,
    :valid_with_correct_attributes,
    :not_valid_with_empty_attributes,
    :saves_with_valid_attributes
  ]
  # rubocop:enable Lint/ConstantDefinitionInBlock

  {
    Cmor::Legal::PersonalData => { specs_to_skip: [ :is_an_active_record, :saves_with_valid_attributes ], factory_name: :cmor_legal_personal_data  },
    Cmor::Legal::PrivacyPolicy => {}
  }.each do |model, options|
    options.reverse_merge!(specs_to_run: DEFAULT_SPECS_TO_RUN, specs_to_skip: [], factory_name: model.to_s.tableize.singularize.underscore.tr("/", "_"))
    specs_to_run = options.delete(:specs_to_run)
    specs_to_skip = options.delete(:specs_to_skip)
    factory_name = options.delete(:factory_name)
    specs = specs_to_run - specs_to_skip

    describe model do
      if specs.include?(:is_an_active_record)
        it "is an ActiveRecord::Base" do
          expect(ActiveRecord::Base.descendants).to include(model)
        end
      end

      if specs.include?(:is_instanciable)
        it "is instanciable" do
          instance = model.new
          expect(instance).to be_a(model)
        end
      end

      if specs.include?(:valid_with_correct_attributes)
        it "is valid with correct attribute values" do
          instance = build(factory_name)

          instance.valid?
          expect(instance.errors.full_messages).to eq([])
        end
      end

      if specs.include?(:not_valid_with_empty_attributes)
        it "is not valid with empty attributes" do
          instance = model.new
          expect(instance).not_to be_valid
        end
      end

      if specs.include?(:saves_with_valid_attributes)
        it "saves with valid attributes" do
          instance = build(factory_name)
          expect(instance.save).to be_truthy
          expect(instance).to be_persisted
        end
      end
    end
  end
end
