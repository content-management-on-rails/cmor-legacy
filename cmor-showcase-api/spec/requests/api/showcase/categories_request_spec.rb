require "rails_helper"

RSpec.describe "/api/showcase/categories", type: :request do
  let(:base_path) { "/api/showcase/categories" }
  let(:resource_class) { Cmor::Showcase::Category }
  let(:factory_name) { resource_class.name.underscore.gsub("/", "_") }
  let(:attribute_keys) { %w[body created_at identifier locale name position published_at slug updated_at] }
  let(:param_key) { resource_class.name.demodulize.underscore.to_sym }

  describe "GET /" do
    let(:collection) { create_list(factory_name, 3) }
    let(:index_path) { base_path }
    let(:headers) { {"Accept" => "application/json"} }

    before(:each) do
      collection
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

        it { expect(subject.size).to eq(collection.size) }
        it { expect(subject.first["attributes"].keys).to match_array(attribute_keys) }
      end
    end
  end

  describe "GET /:id" do
    let(:resource) { create(factory_name) }
    let(:show_path) { "#{base_path}/#{resource.id}" }
    let(:headers) { {"Accept" => "application/json"} }

    before(:each) do
      get(show_path, headers: headers)
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

        it { expect(subject.keys).to match_array(%w[attributes id]) }
        it { expect(subject["id"]).to eq(resource.id) }
        it { expect(subject["attributes"].keys).to match_array(attribute_keys) }
      end
    end
  end

  describe "POST /" do
    let(:create_path) { base_path }
    let(:headers) { {"Accept" => "application/json"} }
    let(:params) { { param_key => attributes_for(factory_name) } }

    describe "when not authenticated" do
      before(:each) do
        post(create_path, headers: headers, params: params)
      end

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

      describe "response" do
        before(:each) do
          post(create_path, headers: headers, params: params)
        end

        it { expect(response).to have_http_status(:created) }
        it { expect(JSON.parse(response.body).keys).to match_array(%w[data meta]) }

        describe "data" do
          subject { JSON.parse(response.body)["data"] }

          it { expect(subject.keys).to match_array(%w[attributes id]) }
          it { expect(subject["id"]).to be_present }
          it { expect(subject["attributes"].keys).to match_array(attribute_keys) }
        end
      end

      describe "persistence changes" do
        it { expect{ post(create_path, headers: headers, params: params) }.to change{ resource_class.count }.from(0).to(1) }
      end
    end
  end

  describe "PUT /:id" do
    let(:resource) { create(factory_name) }
    let(:update_path) { "#{base_path}/#{resource.id}" }
    let(:headers) { {"Accept" => "application/json"} }
    let(:params) { { param_key => {name: "New name"}} }

    describe "when not authenticated" do
      before(:each) do
        put(update_path, headers: headers, params: params)
      end

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

      describe "response" do
        before(:each) do
          put(update_path, headers: headers, params: params)
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(JSON.parse(response.body).keys).to match_array(%w[data meta]) }

        describe "data" do
          subject { JSON.parse(response.body)["data"] }

          it { expect(subject.keys).to match_array(%w[attributes id]) }
          it { expect(subject["id"]).to eq(resource.id) }
          it { expect(subject["attributes"].keys).to match_array(attribute_keys) }
        end
      end

      describe "persistence changes" do
        it { expect{ put(update_path, headers: headers, params: params) }.to change{ resource.reload.name }.to("New name") }
      end
    end
  end

  describe "DELETE /:id" do
    let(:resource) { create(factory_name) }
    let(:delete_path) { "#{base_path}/#{resource.id}" }
    let(:headers) { {"Accept" => "application/json"} }

    describe "when not authenticated" do
      before(:each) do
        delete(delete_path, headers: headers)
      end

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

      describe "response" do
        before(:each) do
          delete(delete_path, headers: headers)
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(JSON.parse(response.body).keys).to match_array(%w[data meta]) }

        describe "data" do
          subject { JSON.parse(response.body)["data"] }

          it { expect(subject.keys).to match_array(%w[attributes id]) }
          it { expect(subject["id"]).to eq(resource.id) }
          it { expect(subject["attributes"].keys).to match_array(attribute_keys) }
        end
      end

      describe "persistence changes" do
        before(:each) { resource }

        it { expect{ delete(delete_path, headers: headers) }.to change{ resource_class.count }.from(1).to(0) }
      end
    end
  end
end
