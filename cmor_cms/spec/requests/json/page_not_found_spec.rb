require 'rails_helper'

RSpec.describe 'json format / page not found', type: :request do
  before(:each) do
    get '/en/not-existent-page.xml'
  end

  it 'responds with json' do
    expect(response.content_type).to eq("application/xml")
    expect(response).to have_http_status(:not_found)
    expect(response.body).to eq('')
  end
end
