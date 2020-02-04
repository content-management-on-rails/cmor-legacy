require 'rails_helper'

RSpec.describe 'Cookie Banner', type: :feature, js: true do
  describe 'visibility' do
    before(:each) do
      visit '/'
    end

    it { expect(page.body).to have_css('#cookies-eu-modal') }
  end

  describe 'forwarding of url paramters' do
    let(:query_string) { 'foo=bar' }
    before(:each) do
      visit "/?#{query_string}"
      within('#cookies-eu-modal') { find('input[type=submit]').click }
    end

    it { expect(current_url.split("?").last).to eq(query_string) }
  end
end