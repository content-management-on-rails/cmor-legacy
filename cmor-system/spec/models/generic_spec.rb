# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'ActiveRecord::Core models' do
  DEFAULT_SPECS_TO_RUN = [
    :is_an_active_record_model,
    :is_instanciable,
    :valid_with_correct_attributes,
    :not_valid_with_empty_attributes,
    :saves_with_valid_attributes
  ]

  {
    Cmor::System::Rack::Attack::BannedIp => { skip: [:is_an_active_record_model] },
    Cmor::System::Changelog              => { skip: [:is_an_active_record_model] }
  }.each do |model, options|
    options.reverse_merge!(run: DEFAULT_SPECS_TO_RUN, skip: [], vcr: false, before: {}, around: {})

    run   = options.delete(:run)
    skip  = options.delete(:skip)
    specs = run - skip

    describe_options = { vcr: options[:vcr] }
    describe(model, describe_options) do
      options.delete(:before).each do |type, block|
        before(type, &block)
      end

      options.delete(:around).each do |type, block|
        around(type) { |example| block.call(example) }
      end

      it 'is an ActiveRecord::Core model' do
        expect(model.included_modules).to include(ActiveRecord::Core)
      end if specs.include?(:is_an_active_record_model)

      it 'is instanciable' do
        instance = model.new
        expect(instance).to be_a(model)
      end if specs.include?(:is_instanciable)

      it 'is valid with correct attribute values' do
        instance = FactoryBot.build(model.to_s.tableize.singularize.underscore.tr('/', '_'))
        expect(instance).to be_valid
      end if specs.include?(:valid_with_correct_attributes)

      it 'is not valid with empty attributes' do
        instance = model.new
        expect(instance).not_to be_valid
      end if specs.include?(:not_valid_with_empty_attributes)
    end
  end
end
