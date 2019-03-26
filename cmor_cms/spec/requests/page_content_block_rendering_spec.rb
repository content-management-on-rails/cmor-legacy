require 'rails_helper'

describe 'content block rendering' do
  before do
    @content_box = Cmor::Cms::ContentBox.create! do |cb|
      cb.name = 'sidebar'
    end

    @page_model = Cmor::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'foo'
      page.locale   = 'en'
      page.format   = ''
      page.handler  = 'textile'
      page.title    = 'Home'
      page.body     = 'h1. Home'
    end

    content_block = Cmor::Cms::ContentBlock.create! do |cb|
      cb.page = @page_model
      cb.content_box = @content_box
      cb.body = 'h1. Sidebar'
    end
  end # before

  context 'when rendering the page' do
    before do
      get '/en/foo'
    end # before

    it 'should render the content block body' do
      response.body.should include('<h1>Sidebar</h1>')
    end # it
  end # context 'when rendering the page'
end # describe "content block rendering"
