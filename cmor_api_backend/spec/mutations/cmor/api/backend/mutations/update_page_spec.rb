require 'rails_helper'

RSpec.describe Cmor::Cms::Backend::Mutations::UpdatePage, type: :request do
  describe '.resolve' do
    let(:api_endpoint)    { '/api/backend/graphql' }
    let(:request_headers) { { "Authorization" => "Bearer: #{user.single_access_token}" } }

    let(:resource_class)  { Cmor::Cms::Page }
    let(:resource)        { create(resource_class.name.underscore.gsub("/", "_")) }
    let(:attributes)      { { title: "A new title", body: "A new body." }.merge(id: resource.id) }
    let(:mutation_name)   { described_class.name.demodulize.camelize(:lower) }
    let(:type_name)       { resource_class.name.demodulize.camelize(:lower) }
    let(:user)            { create(:cmor_user_area_user, :authenticable) }

    let(:query) do
      <<~GQL
        mutation {
          #{mutation_name}(input: {#{ attributes.map {|k,v| "#{k.to_s.camelize(:lower)}: \"#{v}\"" }.join(", ") }}) {
            #{type_name} {
              #{resource_class.attribute_names.map { |a| a.camelize(:lower) }.join("\n")}
            }
            errors {
              message
              path
            }
          }
        }
      GQL
    end

    before(:each) { user; resource }

    describe 'returns the exepected resource' do
      let(:parsed_response_body) { JSON.parse(response.body) }

      before(:each) do
        post api_endpoint, params: { query: query }, headers: request_headers
      end

      describe "response body" do
        it { expect(parsed_response_body.keys).to match_array(["data"]) }

        describe "response body errors" do
          it { expect(parsed_response_body['errors']).to be_nil }
        end

        describe "response body data" do
          it { expect(parsed_response_body['data'].keys).to match_array([mutation_name]) }

          describe "response body data mutation_name" do
            it { expect(parsed_response_body['data'][mutation_name].keys).to match_array(['errors', type_name]) }

            describe "response body data mutation_name errors" do
              it { expect(parsed_response_body['data'][mutation_name]['errors']).to eq([]) }
            end

            describe "response body data mutation_name type_name" do
              it { expect(parsed_response_body['data'][mutation_name][type_name].keys).to match_array(resource_class.attribute_names.map { |a| a.camelize(:lower) }.sort) }
              it { expect(parsed_response_body['data'][mutation_name][type_name].slice(*attributes.keys.map { |k| k.to_s.camelize(:lower) })).to match(attributes.each_with_object({}) { |(k,v),m| m[k.to_s.camelize(:lower)] = v.to_s }) }
            end
          end
        end
      end
    end
  end
end
