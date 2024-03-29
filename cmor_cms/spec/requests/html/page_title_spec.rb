require 'rails_helper'

RSpec.describe 'title rendering', type: :request do
  let(:page) do
    Cmor::Cms::Page.create! do |page|
      page.pathname  = '/'
      page.basename  = 'home'
      page.locale    = 'en'
      page.format    = 'html'
      page.handler   = 'erb'
      page.title     = 'This is the title'
      page.body      = '<h1>Home</h1>'
      page.published = true
    end
  end

  before(:each) do
    page
    get '/en'
  end
    
  it 'adds the title to the page' do
    expect(response.body).to include("<title>This is the title - My Page</title>")
  end
end
