require 'rails_helper'

describe "ActiveRecord::Base models" do
  [
    [Cmor::Contact::ContactRequest],
  ].flatten.each do |model|
    describe model do
      it "is an ActiveRecord::Base" do
        expect(ActiveRecord::Base.descendants).to include(model)
      end

      it "is instanciable" do
        instance = model.new
        expect(instance).to be_a(model)
      end

      it "is valid with correct attribute values" do
        instance = FactoryBot.create(model.to_s.tableize.singularize.underscore.gsub( '/', '_'))
        expect(instance.valid?).to be_truthy
      end

      it "is not valid with empty attributes" do
        instance = model.new
        expect(instance.valid?).to be_falsey
      end

      it "saves with valid attributes" do
        instance = FactoryBot.create(model.to_s.tableize.singularize.underscore.gsub( '/', '_'))
        expect(instance.save).to be_truthy
        expect(instance.persisted?).to be_truthy
      end
    end
  end
end
