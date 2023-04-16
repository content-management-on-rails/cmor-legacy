require "rails_helper"

RSpec.describe "/en/api/restaurant/categories", type: :request do
  let(:base_path) { "/en/api/restaurant/categories" }
  let(:factory_name) { :cmor_restaurant_category }

  describe "GET /.json" do # index
    let(:resources) { create_list(factory_name, 3) }
    let(:index_path) { "#{base_path}.json" }

    describe "response" do
      before(:each) do
        resources
        get index_path
      end

      it { expect(response).to be_successful }
      it { expect(response.parsed_body).to be_a(Hash) }
      it { expect(response.parsed_body.keys).to match_array(["data", "meta"]) }

      describe "data" do
        it { expect(response.parsed_body["data"]).to be_a(Array) }
        it { expect(response.parsed_body["data"].size).to eq(3) }
      end
    end
  end

  describe "GET /.json?populate[foods]=true" do # index with foods
    let(:resources) { create_list(factory_name, 3) }
    let(:index_path) { "#{base_path}.json?populate=foods" }
    let(:foods) { create_list(:cmor_restaurant_food, 3, category: resources.first) }

    describe "response" do
      before(:each) do
        resources
        foods
        get index_path
      end

      it { expect(response).to be_successful }
      it { expect(response.parsed_body["message"]).to eq(nil) }

      describe "data" do
        it { expect(response.parsed_body["data"].first["attributes"].keys).to include("foods") }

        describe "foods" do
          it { expect(response.parsed_body["data"][0]["attributes"]["foods"]["data"].size).to eq(3) }
        end
      end
    end
  end

  describe "GET /:id.json" do # show
    let(:resource) { create(factory_name) }
    let(:show_path) { "#{base_path}/#{resource.id}.json" }

    before(:each) do
      get show_path
    end

    describe "response" do
      it { expect(response).to be_successful }
      it { expect(response.parsed_body).to be_a(Hash) }
      it { expect(response.parsed_body.keys).to match_array(["data"]) }

      describe "data" do
        it { expect(response.parsed_body["data"]).to be_a(Hash) }
        it { expect(response.parsed_body["data"].keys).to match_array(["id", "attributes"]) }

        describe "attributes" do
          it { expect(response.parsed_body["data"]["attributes"].keys).to match_array(["identifier", "name", "description", "parentId", "lft", "rgt", "depth", "slug", "createdAt", "updatedAt", "childrenCount", "locale", "publishedAt", "foods", "published"]) }
        end
      end
    end
  end

  describe "GET /:id.json?populate[foods]=true" do # show with foods
    let(:resource) { create(factory_name) }
    let(:show_path) { "#{base_path}/#{resource.id}.json?populate[foods]=true" }
    let(:foods) { create_list(:cmor_restaurant_food, 3, category: resource) }

    before(:each) do
      foods
      get show_path
    end

    describe "response" do
      it {
        expect(response).to be_successful
      }

      describe "data" do
        describe "attributes" do
          it { expect(response.parsed_body["data"]["attributes"].keys).to include("foods") }

          describe "foods" do
            it { expect(response.parsed_body["data"]["attributes"]["foods"]["data"].size).to eq(3) }
          end
        end
      end
    end
  end
end
