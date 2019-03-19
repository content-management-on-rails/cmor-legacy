require 'rails_helper'

describe 'ActiveRecord::Base models' do
  ActiveRecord::Base.descendants.map(&:to_s).reject { |m| %w(Delayed::Backend::ActiveRecord::Job).include?(m) }.each do |model_name|
    model = model_name.constantize
    describe model do
      it 'should be an ActiveRecord::Base' do
        expect(ActiveRecord::Base.descendants).to include(model)
      end

      it 'should be instanciable' do
        instance = model.new
        expect(instance).to be_a(model)
      end

      it 'should be valid with correct attribute values' do
        instance = create(model.to_s.tableize.singularize.underscore.tr('/', '_'))
        expect(instance.valid?).to be_truthy
      end

      it 'should not be valid with empty attributes' do
        instance = model.new
        expect(instance.valid?).to be_falsey
      end

      it 'should save with valid attributes' do
        instance = create(model.to_s.tableize.singularize.underscore.tr('/', '_'))
        expect(instance.save).to be_truthy
        expect(instance).to be_persisted
      end
    end
  end
end
