require 'rails_helper'

RSpec.describe Cmor::MultiTenancy::Client, type: :model do
  describe 'DefaultConcern' do
    it { expect(described_class).to respond_to(:default) }
    it { expect(subject).to respond_to(:default=) }
    it { expect(subject).to respond_to(:default) }
  end

  describe 'ActiveConcern' do
    it { expect(described_class).to respond_to(:active) }
  end
end