require "rails_helper"

RSpec.describe Cmor::Core::Settings::Settable, type: :model do
  around(:each) do |example|
    settables = Cmor::Core::Settings::Settable.all
    Cmor::Core::Settings::Settable.delete_all
    example.run
    settables.map(&:save!)
  end

  describe "class methods" do
    subject { described_class }

    describe "#create" do
      it "registers a setting" do
        expect { subject.create(namespace: :cmor_core_backend, key: :foo, default: "bar") }.to change { Cmor::Core::Settings::Settable.count }.by(1)
      end
    end

    describe "#all" do
      it { expect(subject.all).to be_a(Rao::ActiveCollection::Relation) }
    end

    describe "#find_by_namespace_and_key" do
      before(:each) { subject.create(namespace: :cmor_core_backend, key: :foo, default: "bar", validations: { presence: true }) }

      it { expect(subject.where(namespace: :cmor_core_backend, key: :foo).first).to be_a(Cmor::Core::Settings::Settable) }
    end
  end

  describe "#value" do
    it { expect(subject).to respond_to(:value) }

    describe "when setting exists" do
      subject { described_class.new(namespace: :cmor_core_backend, key: :foo, default: "bar") }

      before(:each) { subject.value = "baz"; subject.setting.save! }

      it { expect(subject.value).to eq("baz") }
    end

    describe "when default" do
      subject { described_class.new(namespace: :cmor_core_backend, key: :foo, default: "bar") }

      it { expect(subject.value).to eq("bar") }
    end
  end
end
