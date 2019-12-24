require 'rails_helper'

RSpec.describe Cmor::UserArea::Backend::Mutations::CallCreateDefaultUserService, type: :request do
  describe '.resolve' do
    let(:api_endpoint)    { '/api/backend/graphql' }
    let(:request_headers) { { "Authorization" => "Bearer: #{user.single_access_token}" } }

    let(:attributes)      { { } }
    let(:options)         { { silence: true } }
    let(:mutation_name)   { described_class.name.demodulize.camelize(:lower) }
    let(:type_name)       { mutation_name }
    let(:user)            { create(:cmor_user_area_user, :authenticable) }

    let(:query) do
      <<~GQL
        mutation {
          callCreateDefaultUserService(input: { attributes: { #{attributes.map { |k,v| "#{k}: #{v}" }.join(', ') }}, options: {#{options.map { |k,v| "#{k}: #{v}" }.join(', ') }}  }) {
            success
            status
            errors {
              message
              path
            }
            messages {
              indentLevel
              prefix
              content
              suffix
            }
          }
        }
      GQL
    end

    before(:each) { user }

    describe 'returns the exepected resource' do
      let(:parsed_response_body) { JSON.parse(response.body) }

      describe "changes" do
        it do
          puts query
          expect {
            post api_endpoint, params: { query: query }, headers: request_headers
          }.to change {
            Cmor::UserArea::User.count
          }.by(1)
        end
      end

      describe "response body" do
        before(:each) do
          post api_endpoint, params: { query: query }, headers: request_headers
        end

        it { expect(parsed_response_body.keys).to match_array(["data"]) }

        describe "response body errors" do
          it { expect(parsed_response_body['errors']).to be_nil }
        end

        describe "response body data" do
          it { expect(parsed_response_body['data'].keys).to match_array([mutation_name]) }

          describe "response body data mutation_name" do
            it { expect(parsed_response_body['data'][mutation_name].keys).to match_array(['errors', 'messages', 'status', 'success']) }

            describe "response body data mutation_name errors" do
              it { expect(parsed_response_body['data'][mutation_name]['errors']).to eq([]) }
            end

            describe "response body data mutation_name status" do
              it { expect(parsed_response_body['data'][mutation_name]['status']).to eq('success') }
            end

            describe "response body data mutation_name success" do
              it { expect(parsed_response_body['data'][mutation_name]['success']).to eq(true) }
            end

            describe "response body data mutation_name messages" do
              it { expect(parsed_response_body['data'][mutation_name]['messages']).to be_a(Array) }
            end
          end
        end
      end
    end
  end
end
