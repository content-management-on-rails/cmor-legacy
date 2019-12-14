require 'rails_helper'

RSpec.describe Cmor::Api::Backend::Queries, type: :request do
    let(:user)            { create(:cmor_user_area_user, :authenticable) }
    let(:api_endpoint)    { '/api/backend/graphql' }
    let(:request_headers) { { "Authorization" => "Bearer: #{user.single_access_token}" } }


  %w(
    Cmor::Blog::Post
    Cmor::UserArea::User
    Cmor::Cms::Page
  ).each do |model_class_name|
    describe model_class_name.demodulize.underscore.pluralize
    it do
      resource_class = model_class_name.constantize
      collection = create_list(model_class_name.underscore.gsub("/", "_"), 3)
      method_name = model_class_name.demodulize.underscore.pluralize

      query = <<~GQL
        query{
          #{method_name}{
          #{resource_class.attribute_names.map { |a| "  #{a}"}.join("\n  ") }
          }
        }
      GQL
puts query
      post api_endpoint, params: { query: query }, headers: request_headers
      parsed_response_body = JSON.parse(response.body)
      expect(parsed_response_body['errors']).to eq([])
      expect(parsed_response_body.keys).to match_array(['data'])
    end
  end
end