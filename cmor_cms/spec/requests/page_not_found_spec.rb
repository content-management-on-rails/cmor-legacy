require 'rails_helper'

describe '404 support' do
  it 'throws a 404 for unknown pages' do
    get '/en/not-existent-page'
    expect(response.response_code).to eq(404)
  end
end
