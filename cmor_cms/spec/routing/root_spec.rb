require 'rails_helper'

describe 'routing to the localized root path' do
  it "routes /en to page#respond and page 'home'" do
    expect(get: '/en').to route_to(
      locale: 'en',
      controller: 'cmor/cms/page',
      action: 'respond',
      page: 'home'
    )
  end

  it "routes /de to page#respond and page 'home'" do
    expect(get: '/de').to route_to(
      locale: 'de',
      controller: 'cmor/cms/page',
      action: 'respond',
      page: 'home'
    )
  end
end
