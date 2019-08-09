require 'rails_helper'

RSpec.describe '404 support', type: :request do
  it 'throws a 404 for unknown pages' do
    pending "RSpec ignores rescue_from"
    get '/en/not-existent-page'
    expect(response).to have_http_status(:not_found)
  end
end
