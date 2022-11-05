require 'rails_helper'

RSpec.describe '/de', type: :feature do
#  describe 'when no client is specified' do
#    let(:base_path) { '/de' }
#    let(:default_client) { create(:cmor_multi_tenancy_client, default: true) }
#
#    before(:each) do
#      default_client
#      visit(base_path)
#    end
#
#    it { expect(page.body).to include(default_client.title) }
#  end
#
#  describe 'when a client is specified via param' do
#    let(:base_path) { "/de/#{current_client.identifier}" }
#    let(:current_client) { create(:cmor_multi_tenancy_client, default: false) }
#
#    around(:each) do |example|
#      original_value = Cmor::MultiTenancy::Configuration.current_client_key
#      Cmor::MultiTenancy::Configuration.current_client_key = :client_identifier
#      example.run
#      Cmor::MultiTenancy::Configuration.current_client_key = original_value
#    end
#
#    before(:each) { visit(base_path) }
#
#    it { expect(page.body).to include(current_client.title) }
#  end

  describe 'when a client is specified via subdomain' do
    let(:base_path) { "/de/#{current_client.identifier}" }
    let(:default_client) { create(:cmor_multi_tenancy_client, default: true, title: "Default") }
    let(:current_client) { create(:cmor_multi_tenancy_client, default: false) }

    around(:each) do |example|
      original_value = Cmor::MultiTenancy::Configuration.current_client_key
      Cmor::MultiTenancy::Configuration.current_client_key = :subdomain
      example.run
      Cmor::MultiTenancy::Configuration.current_client_key = original_value
    end

    before(:each) do
      default_client
      visit(base_path)
    end

    it { expect(page.body).to include(default_client.title) }
  end
end