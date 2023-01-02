require "rails_helper"

RSpec.describe "/api/cmor-contact/contact_requests", type: :request do
  let(:base_path) { "/api/cmor-contact/contact_requests" }

  describe "POST index" do
    let(:index_path) { base_path }
    let(:headers) { {"Accept" => "application/json"} }
    let(:params) { {contact_request: attributes_for(:cmor_contact_contact_request)} }

    before(:each) do
      post(index_path, headers: headers, params: params)
    end

    describe "when not authenticated" do
      it { expect(response).to have_http_status(:unauthorized) }
    end

    describe "when authenticated" do
      let(:api_token) { create(:cmor_core_api_api_token) }
      let(:headers) do
        {
          "Accept" => "application/json",
          "Authorization" => "Bearer #{api_token.token}"
        }
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(JSON.parse(response.body).keys).to match_array(%w[data]) }

      describe "data" do
        subject { JSON.parse(response.body)["data"] }

        it { expect(subject["attributes"].keys).to match_array(%w[accept_terms_of_service created_at email ip_address message name notified_at phone updated_at]) }
      end
    end
  end
end
