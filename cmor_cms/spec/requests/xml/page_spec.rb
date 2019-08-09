require 'rails_helper'

describe 'json format / page' do
  let(:parsed_response) { JSON.parse(response.body) }
  let(:page_model) do
    Cmor::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'foo'
      page.locale   = 'en'
      page.format   = 'html'
      page.handler  = 'erb'
      page.title    = 'Home'
      page.body     = '<h1>Home</h1>'
    end
  end

  before(:each) do
    page_model
    get '/en/foo.xml'
  end

  it 'responds with a 404 as we do not support xml atm' do
    expect(response.content_type).to eq("application/xml")
    expect(response).to have_http_status(:not_found)
    expect(response.body).to eq('')
  end
end
