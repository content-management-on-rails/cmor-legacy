require 'rails_helper'

describe 'routing to pages' do
  # routes { Cmor::Cms::Engine.routes }

  it 'routes /foo to cmor/cms/page#respond' do
    expect(get: '/en/foo').to route_to(
      locale: 'en',
      controller: 'cmor/cms/page',
      action: 'respond',
      page: 'foo'
    )
  end

  it 'routes a deeply nested page to cmor/cms/page#respond' do
    expect(get: '/en/this/is/a/deeply/nested/page').to route_to(
      locale: 'en',
      controller: 'cmor/cms/page',
      action: 'respond',
      page: 'this/is/a/deeply/nested/page'
    )
  end
end
