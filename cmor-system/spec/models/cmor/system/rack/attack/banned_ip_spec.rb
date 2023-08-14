require 'rails_helper'
require 'rack/attack'

RSpec.describe Cmor::System::Rack::Attack::BannedIp, type: :model do
  around do |example|
    @_original_cache_store = Rack::Attack.cache.store
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
    example.run
    Rack::Attack.cache.store = @_original_cache_store
  end

  describe 'class methods' do
    describe 'create' do
      it { expect{ described_class.create(key: 'rack::attack:allow2ban:ban:10.0.2.2') }.to change{ described_class.count }.from(0).to(1) }
    end

    describe 'new' do
      it { expect(described_class.new).to be_a(described_class) }
    end

    describe 'all' do
      before(:each) { create_list(:cmor_system_rack_attack_banned_ip, 3) }

      it { expect(described_class.all).to be_a(Array) }
      it { expect(described_class.all.size).to eq(3) }
    end

    describe 'find' do
      let(:banned_ips) { create_list(:cmor_system_rack_attack_banned_ip, 3) }
      let(:the_one) { create(:cmor_system_rack_attack_banned_ip, key: 'rack::attack:allow2ban:ban:10.0.2.42') }

      let(:id) { Digest::SHA1.hexdigest('rack::attack:allow2ban:ban:10.0.2.42') }

      before(:each) do
        banned_ips
        the_one
      end

      it { expect(described_class.find(id)).to eq(the_one) }
    end
  end

  describe 'instance methods' do
    describe 'to_param' do
      subject { build(:cmor_system_rack_attack_banned_ip) }

      it { expect(subject.to_param).to be_present }
    end

    describe 'id' do
      subject { build(:cmor_system_rack_attack_banned_ip) }

      it { expect(subject.id).to be_present }
    end
    
    describe 'save' do
      subject { build(:cmor_system_rack_attack_banned_ip) }

      it { expect{ subject.save }.to change{ described_class.count }.from(0).to(1) }
    end

    describe 'update' do
      subject { create(:cmor_system_rack_attack_banned_ip) }

      it { expect{ subject.update(key: "rack::attack:allow2ban:ban:10.0.3.1") }.not_to change{ described_class.count } }
    end
  end
end
