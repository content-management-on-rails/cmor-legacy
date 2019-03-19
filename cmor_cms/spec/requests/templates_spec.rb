require 'rails_helper'

describe 'rendering a view from a controller' do
  it "displays the '/page_test/index.html.erb' page content when accessing page_test#index" do
    record = Cmor::Cms::Template.create! do |record|
      record.pathname = '/page_test/'
      record.basename = 'index'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.body     = '<h1>page_test#index</h1>\nFind me in page_test/index.html.erb\n'
    end
    get '/en/page_test'

    response.body.should include(record.body)
  end
end
