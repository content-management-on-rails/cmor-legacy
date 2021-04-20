require 'rails_helper'

describe 'json format / page' do
  let(:parsed_response) { JSON.parse(response.body) }
  let(:page_model) do
    Cmor::Cms::Page.create! do |page|
      page.pathname  = '/'
      page.basename  = 'foo'
      page.locale    = 'en'
      page.format    = 'html'
      page.handler   = 'erb'
      page.title     = 'Home'
      page.body      = '<h1>Home</h1>'
      page.published = true
    end
  end

  before(:each) do
    page_model
    get '/en/foo.json'
  end

  it 'responds with json' do
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:success)
    expect(parsed_response).to be_a(Hash)
    expect(parsed_response.keys.sort).to eq(%w(content))
    expect(parsed_response['content']).to eq(page_model.body)
  end
end
