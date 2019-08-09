require 'rails_helper'

RSpec.describe 'json format / page not found', type: :request do
  before(:each) do
    get '/en/not-existent-page.json'
  end

  it 'responds with json' do
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:not_found)
    expect(response.body).to eq('')
  end
end
