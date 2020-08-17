require 'rails_helper'

RSpec.describe 'Redirect', type: :request do
  describe 'basic usage' do
    let(:redirect) { create(:cmor_cms_redirect, source: '/source', target: '/target', published: true) }
    let(:source_path) { '/source' }
    let(:target_path) { '/target' }

    before(:each) do
      redirect
      get(source_path)
    end

    it { expect(response).to redirect_to(target_path) }
  end
end
