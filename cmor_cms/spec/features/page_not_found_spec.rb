require 'rails_helper'

RSpec.describe '404 support', type: :feature do
  around(:each) do |example|
    value = Rails.application.config.consider_all_requests_local
    Rails.application.config.consider_all_requests_local = false
    example.run
    Rails.application.config.consider_all_requests_local = value
  end

  it 'throws a 404 for unknown pages' do
    visit '/en/not-existent-page'
    expect(response.response_code).to eq(404)
  end
end
