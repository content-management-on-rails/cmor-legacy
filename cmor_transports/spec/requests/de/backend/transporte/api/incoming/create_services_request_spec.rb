require 'rails_helper'

RSpec.describe "/de/backend/transporte/api/incoming/create_services.json", type: :request do
  let(:base_url) { "/de/backend/transporte/api/incoming/create_services.json" }
  let(:outgoing) { create(:cmor_transports_outgoing) }
  let(:params) { { create_service: { outgoing: outgoing.as_json(methods: :output_base64) } } }
  let(:headers) { {} }

  let(:parsed_response) { JSON.parse(response.body) }

  describe 'response' do
    before(:each) do
      post(base_url, params: params, headers: headers)
    end

    it { expect(response.content_type).to eq("application/json") }
    it { expect(response).to have_http_status(:created) }
    it { expect(parsed_response['errors']).to eq({}) }
  end

  describe 'changes' do
    it { expect { post(base_url, params: params, headers: headers) }.to change { Cmor::Transports::Incoming.count }.from(0).to(1) }
  end
end