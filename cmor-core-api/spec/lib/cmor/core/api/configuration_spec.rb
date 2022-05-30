require 'rails_helper'

module Cmor::Core::Api
  RSpec.describe Configuration do
    subject { described_class }
    
    describe 'engines' do
      it { expect(subject).to respond_to(:registered_engines) }
    end

    describe 'register_engine' do
      it { expect(subject).to respond_to(:register_engine) }
      
      describe 'registering' do
        before(:each) { subject.register_engine("Foo::Engine", {}) }

        it { expect(described_class.registered_engines).to be_a(Array) }
        it { expect(described_class.registered_engines.size).to eq(1) }
      end
    end
  end
end
