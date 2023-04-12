require 'rails_helper'

RSpec.describe 'requesting a page' do
  describe "requesting '/' redirects to the default locale" do
    it 'redirects' do
      get '/'
      expect(response).to redirect_to("/#{I18n.default_locale}")
    end
  end

  describe 'localized home page' do
    it "displays the 'home' page content" do
      page_model = Cmor::Cms::Page.create! do |page|
        page.pathname  = '/'
        page.basename  = 'home'
        page.locale    = 'en'
        page.format    = 'html'
        page.handler   = 'erb'
        page.title     = 'Home'
        page.body      = '<h1>Home</h1>'
        page.published = true
      end
      get '/en'
      expect(response.body).to include(page_model.body)
    end
  end

  describe 'requesting unpublished page' do
    it 'requesting /unpublished should not succeed' do
      page_model = Cmor::Cms::Page.create! do |page|
        page.pathname  = '/'
        page.basename  = 'unpublished'
        page.locale    = 'en'
        page.format    = 'html'
        page.handler   = 'erb'
        page.title     = 'Home'
        page.body      = '<h1>Unpublished</h1>'
        page.published = false
      end
      expect { get '/en/unpublished'}.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'requesting a nested page' do
    it 'requesting /foo/bar/baz should succeed' do
      page_model = Cmor::Cms::Page.create! do |page|
        page.pathname  = '/foo/bar/'
        page.basename  = 'baz'
        page.locale    = 'en'
        page.format    = 'html'
        page.handler   = 'erb'
        page.title     = 'Home'
        page.body      = '<h1>Foo/Bar</h1>'
        page.published = true
      end
      get '/en/foo/bar/baz'
      expect(response.body).to include(page_model.body)
    end
  end

  describe 'requesting a text template' do
    it 'requesting /de/test.txt should succeed' do
      page_model = Cmor::Cms::Page.create! do |page|
        page.pathname  = '/'
        page.basename  = 'test'
        page.format    = 'text'
        page.handler   = 'erb'
        page.title     = 'Test'
        page.body      = 'Example text template'
        page.published = true
      end
      get '/de/test.txt'
      expect(response.body).to include(page_model.body)
    end
  end

  describe 'page with content blocks' do
    it 'should render the page block content' do
      page_model = Cmor::Cms::Page.create! do |page|
        page.pathname  = '/'
        page.basename  = 'test'
        page.format    = 'html'
        page.handler   = 'erb'
        page.title     = 'Page with content block'
        page.body      = 'Footer content here: <%= content_for?(:footer) ? yield(:footer) : nil %>'
        page.published = true
      end

      content_box = Cmor::Cms::ContentBox.create! do |content_box|
        content_box.name = 'footer'
      end

      footer_content_block = page_model.content_blocks.create! do |content_block|
        content_block.content_box = content_box
        content_block.body = 'This is the footer content'
      end
      get '/de/test'

      expect(response.body).to include(footer_content_block.body)
    end
  end
end
