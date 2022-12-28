require "rails_helper"

RSpec.describe "/api/cmor-blog/asset_details", type: :request do
  let(:base_path) { "/api/cmor-blog/asset_details" }

  describe "GET index" do
    let(:index_path) { base_path }
    let(:headers) { {"Accept" => "application/json"} }

    before(:each) do
      @collection = create_list(:cmor_blog_asset_detail, 3)
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
      it { expect(JSON.parse(response.body).keys).to match_array(%w[data meta]) }

      describe "data" do
        subject { JSON.parse(response.body)["data"] }

        it { expect(subject.size).to eq(3) }
        it { expect(subject.first["attributes"].keys).to match_array(%w[post_id asset_id title description position published_at created_at updated_at asset_url]) }
      end
    end
  end
end
