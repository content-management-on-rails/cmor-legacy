require 'rails_helper'

RSpec.describe Cmor::MultiTenancy::CreateClientService do
  describe 'basic usage' do
    it { expect(described_class.call).to be_a(Cmor::MultiTenancy::CreateClientService::Result) }
    
    describe 'changes' do
      it { expect{ described_class.call }.to change { Cmor::MultiTenancy::Client.count }.from(0).to(1) }
    end
  end
end