require 'rails_helper'
require 'cmor/multi_tenancy/spec_helpers/system'

RSpec.describe '/de (with sudomains)', type: :feature do
  include Cmor::MultiTenancy::SpecHelpers::System

  describe 'www.example.com/de (default subdomain)', type: :feature do
    describe 'when default client is missing' do
      let(:base_path) { '/de' }

      it { expect{ with_subdomain("www") { visit(base_path) } }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    describe 'when default client is present' do
      let(:base_path) { '/de' }
      let(:default_client) { create(:cmor_multi_tenancy_client, default: true) }

      before(:each) do
        default_client
        with_subdomain("www") { visit(base_path) }
      end

      it { expect(page.body).to include(default_client.title) }
    end
  end

  describe 'acme.example.com/de (acme subdomain)', type: :feature do
    describe 'when client is missing' do
      let(:base_path) { '/de' }
      let(:default_client) { create(:cmor_multi_tenancy_client, default: true, identifier: 'default', title: "Default LLC") }

      before(:each) do
        default_client
        with_subdomain('missing') { visit(base_path) }
      end

      it { expect(page.body).to include(default_client.title) }
    end

    describe 'when client is present' do
      let(:base_path) { '/de' }
      let(:default_client) { create(:cmor_multi_tenancy_client, default: true, identifier: 'default', title: "Default LLC") }
      let(:client) { create(:cmor_multi_tenancy_client, identifier: "acme", title: "ACME LLC") }

      before(:each) do
        with_subdomain(client.identifier) { visit(base_path) }
      end

      it { expect(page.body).to include(client.title) }
    end
  end
end
