# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ActiveRecord::Base models", type: :model do
  DEFAULT_SPECS_TO_RUN = [
    :is_an_active_record,
    :is_instanciable,
    :valid_with_correct_attributes,
    :not_valid_with_empty_attributes,
    :saves_with_valid_attributes
  ]

  {
    Cmor::Transports::Export         => {},
    Cmor::Transports::Import         => {},
    Cmor::Transports::Incoming       => {},
    Cmor::Transports::Outgoing       => { specs_to_skip: [ :not_valid_with_empty_attributes ] },
    Cmor::Transports::OutgoingExport => {},
    Cmor::Transports::OutgoingTarget => {},
    Cmor::Transports::System         => {},
  }.each do |model, options|
    options.reverse_merge!(specs_to_run: DEFAULT_SPECS_TO_RUN, specs_to_skip: [])
    specs_to_run = options.delete(:specs_to_run)
    specs_to_skip = options.delete(:specs_to_skip)
    specs = specs_to_run - specs_to_skip

    describe model do
      it "is an ActiveRecord::Base" do
        expect(ActiveRecord::Base.descendants).to include(model)
      end if specs.include?(:is_an_active_record)

      it "is instanciable" do
        instance = model.new
        expect(instance).to be_a(model)
      end if specs.include?(:is_instanciable)

      it "is valid with correct attribute values" do
        instance = build(model.to_s.tableize.singularize.underscore.tr("/", "_"))

        instance.valid?
        expect(instance.errors.full_messages).to eq([])
      end if specs.include?(:valid_with_correct_attributes)

      it "is not valid with empty attributes" do
        instance = model.new
        expect(instance).not_to be_valid
      end if specs.include?(:not_valid_with_empty_attributes)

      it "saves with valid attributes" do
        instance = build(model.to_s.tableize.singularize.underscore.tr("/", "_"))
        expect(instance.save).to be_truthy
        expect(instance).to be_persisted
      end if specs.include?(:saves_with_valid_attributes)
    end
  end
end
