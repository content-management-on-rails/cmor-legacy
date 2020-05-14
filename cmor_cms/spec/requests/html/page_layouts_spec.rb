require 'rails_helper'

RSpec.describe 'pages with different layouts', type: :request do
  let(:layout) do
    create(:cmor_cms_page,
      pathname: '/layouts/',
      basename: 'foo',
      locale: '',
      format: 'html',
      handler: 'erb',
      body: 'Foo Layout <%= yield %>',
      published: true
    )
  end

  let(:page) do
    create(:cmor_cms_page,
      pathname: '/',
      basename: 'home',
      locale: 'en',
      format: 'html',
      layout: '/layouts/foo',
      handler: 'erb',
      published: true
    )
  end

  before(:each) do
    layout
    page
    get '/en'
  end

  it 'uses page specific layouts' do
    expect(response.body).to include('Foo Layout')
  end
end
