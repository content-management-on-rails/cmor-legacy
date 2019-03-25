require 'rails_helper'

RSpec.describe 'pages with different layouts', type: :request do
  it 'uses page specific layouts' do
    pending("Newer rails versions changed the way the layout is specified when rendering ActionView::Templates. It isn't possible to pass options[:layout] anymore. Need to find a way around this.")
    # TODO: replace this with a template as soon as the template model is done.
    layout_model = FactoryBot.create(:cmor_cms_page,
                                      pathname: '/layouts/',
                                      basename: 'foo',
                                      locale: '',
                                      format: 'html',
                                      handler: 'erb',
                                      body: 'Foo Layout <%= yield %>'
                                     )

    page_model = FactoryBot.create(:cmor_cms_page,
                                    pathname: '/',
                                    basename: 'home',
                                    locale: 'en',
                                    format: 'html',
                                    layout: 'layouts/foo',
                                    handler: 'erb'
                                   )
    get '/en'
    response.body.should include('Foo Layout')
  end
end
