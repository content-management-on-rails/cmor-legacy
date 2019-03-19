require 'rails_helper'

describe 'routing to categories' do
  it 'routes /cmor_links_categories to index' do
    expect(get: '/cmor_links_categories').to route_to(
      controller: 'cmor/links/categories',
      action: 'index'
    )
  end

  it 'routes /cmor_links_categories/1 to show with id 1' do
    expect(get: '/cmor_links_categories/1').to route_to(
      controller: 'cmor/links/categories',
      action: 'show',
      id: '1'
    )
  end
end
