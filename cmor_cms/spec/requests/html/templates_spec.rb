require 'rails_helper'

RSpec.describe 'rendering a view from a controller', type: :request do
  let(:page) do
    Cmor::Cms::Page.create do |record|
      record.pathname = '/page_test/'
      record.basename = 'index'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.title    = 'Page Test - index'
      record.body     = '<h1>page_test#index</h1>\nFind me in page_test/index.html.erb\n'
    end
  end

  before(:each) do
    page
    get '/en/page_test'
  end

  it "displays the '/page_test/index.html.erb' page content when accessing page_test#index" do
    expect(response.body).to include(page.body)
  end
end
