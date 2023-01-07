require "rails_helper"

RSpec.describe "/api/cmor-user-area/users", type: :request do
  let(:base_path) { "/api/cmor-user-area/users" }

  describe "GET index" do
    let(:index_path) { base_path }
    let(:headers) { {"Accept" => "application/json"} }

    before(:each) do
      @collection = create_list(:cmor_user_area_user, 3)
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
        it { expect(subject.first["attributes"].keys).to match_array(%w[active approved confirmed created_at crypted_password current_login_at current_login_ip email failed_login_count last_login_at last_login_ip last_request_at login_count otp_backup_codes password_salt perishable_token persistence_token single_access_token tfa_state updated_at]) }
      end
    end
  end
end
