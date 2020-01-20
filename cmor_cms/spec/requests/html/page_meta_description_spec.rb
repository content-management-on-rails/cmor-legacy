require 'rails_helper'

describe 'meta description rendering' do
  it 'adds the meta description to the page' do
    page_model = Cmor::Cms::Page.create! do |page|
      page.pathname            = '/'
      page.basename            = 'home'
      page.locale              = 'en'
      page.format              = 'html'
      page.handler             = 'erb'
      page.title               = 'Some title'
      page.meta_description    = 'This is the meta description'
      page.body                = '<h1>Home</h1>'
      page.published           = true
    end
    get '/en'

    expect(response.body).to include("<meta name=\"description\" content=\"#{page_model.meta_description}\">")
  end
end
