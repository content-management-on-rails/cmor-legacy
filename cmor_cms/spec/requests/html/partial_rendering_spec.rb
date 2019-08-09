require 'rails_helper'

RSpec.describe 'requesting a page that renders a partial', type: :request do
  let(:partial) do
    Cmor::Cms::Partial.create! do |record|
      record.pathname = '/'
      record.basename = 'test'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.body     = 'Test partial'
    end
  end

  let(:page) do
    Cmor::Cms::Page.create! do |record|
      record.pathname = '/partial_test'
      record.basename = 'index'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.title    = 'Partial Test'
      record.body     = '<%= render partial: "/test" %>'
    end
  end

  before(:each) do
    page
    partial
    get '/en/partial_test'
  end

  it 'renders the partial' do
    expect(response.body).to include(partial.body)
  end
end
