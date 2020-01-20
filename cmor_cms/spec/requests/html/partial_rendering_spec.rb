require 'rails_helper'

RSpec.describe 'requesting a page that renders a partial', type: :request do
  let(:page) do
    Cmor::Cms::Page.create! do |record|
      record.pathname  = '/partial_test'
      record.basename  = 'index'
      record.locale    = ''
      record.format    = 'html'
      record.handler   = 'erb'
      record.title     = 'Partial Test'
      record.body      = '<%= render partial: "/test" %>'
      record.published = true
    end
  end

  describe 'with a published partial' do
    let(:partial) do
      Cmor::Cms::Partial.create! do |record|
        record.pathname  = '/'
        record.basename  = 'test'
        record.locale    = ''
        record.format    = 'html'
        record.handler   = 'erb'
        record.body      = 'Published partial'
        record.published = true
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

  describe 'with an unpublished partial' do
    let(:partial) do
      Cmor::Cms::Partial.create! do |record|
        record.pathname  = '/'
        record.basename  = 'test'
        record.locale    = ''
        record.format    = 'html'
        record.handler   = 'erb'
        record.body      = 'Unpublished partial'
        record.published = false
      end
    end

    before(:each) do
      page
      partial
    end

    it 'raises an ActionView::Template::Error' do
      expect { get '/en/partial_test' }.to raise_error(ActionView::Template::Error)
    end
  end
end
