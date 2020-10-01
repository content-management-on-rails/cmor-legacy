require 'rails_helper'
require 'rack/attack'

RSpec.describe '/de/backend/system/rack/attack/banned_ips', type: :feature do
  let(:resource_class) { Cmor::System::Rack::Attack::BannedIp }
  let(:resource) { create(:cmor_system_rack_attack_banned_ip) }
  let(:resources) { create_list(:cmor_system_rack_attack_banned_ip, 3) }

  around do |example|
    # @_original_cache_store = Rails.application.config.cache_store
    # Rails.application.config.cache_store = :memory_store
    # example.run
    # Rails.application.config.cache_store = @_original_cache_store
    @_original_cache_store = Rack::Attack.cache.store
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
    example.run
    Rack::Attack.cache.store = @_original_cache_store
  end

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_rack_attack_banned_ip_') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in 'rack_attack_banned_ip[key]', with: 'rack::attack:allow2ban:ban:10.0.2.1'
      }
      .increasing{ resource_class.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
