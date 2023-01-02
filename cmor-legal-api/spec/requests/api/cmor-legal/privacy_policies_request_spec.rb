require "rails_helper"

RSpec.describe "/api/cmor-legal/privacy_policies", type: :request do
  let(:base_path) { "/api/cmor-legal/privacy_policies" }

  describe "GET index" do
    let(:index_path) { base_path }
    let(:headers) { {"Accept" => "application/json"} }

    before(:each) do
      @resource = create(:cmor_legal_privacy_policy)
      get(index_path, headers: headers)
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

      it { expect(response).to have_http_status(:ok) }
      it { expect(JSON.parse(response.body).keys).to match_array(%w[data]) }

      describe "data" do
        subject { JSON.parse(response.body)["data"] }

        it { expect(subject["id"]).to eq(@resource.id) }
        it { expect(subject["attributes"].keys).to match_array(%w[basename body created_at format handler layout locale meta_description pathname published_at title updated_at]) }
      end
    end
  end
end
