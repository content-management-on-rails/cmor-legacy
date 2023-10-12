require "rails_helper"

RSpec.describe Cmor::Core::Settings do
  around(:each) do |example|
    settables = Cmor::Core::Settings::Settable.all
    Cmor::Core::Settings::Settable.delete_all
    example.run
    Cmor::Core::Settings::Settable.instance_variable_set(:@all, settables)
  end
  
  describe "class methods" do
    subject { described_class }
    
    describe "#get" do
      it { expect(subject).to respond_to(:get) }

      describe "when settable exists" do
        let(:settable) { Cmor::Core::Settings::Settable.create!(namespace: :cmor_core_backend, key: :foo, default: "bar") }

        before(:each) { settable }

        it { expect(subject.get(:cmor_core_backend, :foo)).to eq("bar") }
      end
    end
    
    describe "#set" do
      it { expect(subject).to respond_to(:set) }

      describe "persistence changes" do
        let(:settable) { Cmor::Core::Settings::Settable.create!(namespace: :cmor_core_backend, key: :foo, default: nil) }

        before(:each) { settable }
        
        it { expect{ subject.set(:cmor_core_backend, :foo, "baz") }.to change { subject.get(:cmor_core_backend, :foo) }.from(nil).to("baz") }
      end
    end
  end
end