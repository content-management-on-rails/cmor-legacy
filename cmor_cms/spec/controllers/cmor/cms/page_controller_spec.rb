require 'rails_helper'

RSpec.describe Cmor::Cms::PageController, type: :controller do
  routes { Cmor::Cms::Engine.routes }

  describe "GET respond with page => '/de/foo'" do
    let(:page) do
      Cmor::Cms::Page.create! do |page|
        page.pathname = '/'
        page.basename = 'foo'
        page.locale   = 'de'
        page.format   = 'html'
        page.handler  = 'erb'
        page.title    = 'Foo Page'
      end
    end

    before(:each) do
      page
      get :respond, params: { page: '/foo', locale: 'de' }
    end

    it { expect(response.code).to eq('200') }
  end

  describe "GET respond with page => '/de/foo/bar'" do
    let(:page) do
      Cmor::Cms::Page.create! do |page|
        page.pathname = '/foo/'
        page.basename = 'bar'
        page.locale   = 'de'
        page.format   = 'html'
        page.handler  = 'erb'
        page.title    = 'Foo/Bar (de)'
      end
    end

    before(:each) do
      page
      get :respond, params: { page: '/foo/bar', locale: 'de' }
    end

    it { expect(response.code).to eq('200') }
  end
end
