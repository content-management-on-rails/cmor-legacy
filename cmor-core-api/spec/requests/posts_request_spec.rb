require 'rails_helper'

RSpec.describe "/posts", type: :request do
  let(:base_path) { "/posts" }
  
  describe 'when not authenticated' do
    before(:each) { get(base_path) }

    it { expect(response).to have_http_status(401) }
  end

  describe 'when authenticated' do
    let(:api_token) { create(:cmor_core_api_api_token) }
    let(:request_headers) { { "Authorization" => "Bearer #{api_token.token}" } }
    
    before(:each) { get(base_path, headers: request_headers) }

    it { expect(response).to have_http_status(200) }
  end

  describe "when can't write" do
    let(:api_token) { create(:cmor_core_api_api_token, can_write: false) }
    let(:request_headers) { { "Authorization" => "Bearer #{api_token.token}" } }
    let(:request_params) { { post: attributes_for(:post) } }
    
    before(:each) { post(base_path, headers: request_headers, params: request_params) }

    it { expect(response).to have_http_status(403) }
  end

  describe "when can write" do
    let(:api_token) { create(:cmor_core_api_api_token, can_write: true) }
    let(:request_headers) { { "Authorization" => "Bearer #{api_token.token}" } }
    let(:request_params) { { post: attributes_for(:post) } }
    
    before(:each) { post(base_path, headers: request_headers, params: request_params) }

    it { expect(response).to have_http_status(200) }
  end
end
