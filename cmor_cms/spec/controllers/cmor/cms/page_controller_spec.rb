require 'rails_helper'

module Cmor
  module Cms
    describe PageController do
      describe "GET respond with page => '/de/foo'" do
        before(:each) do
          @page = Cmor::Cms::Page.create! do |page|
            page.pathname = '/'
            page.basename = 'foo'
            page.locale   = 'de'
            page.format   = 'html'
            page.handler  = 'erb'
            page.title    = 'Foo Page'
          end
        end

        it 'should succeed' do
          get :respond, page: '/foo', locale: 'de'
          response.code.should eq('200')
        end
      end

      describe "GET respond with page => '/de/foo/bar'" do
        before(:each) do
          @page = Cmor::Cms::Page.create! do |page|
            page.pathname = '/foo/'
            page.basename = 'bar'
            page.locale   = 'de'
            page.format   = 'html'
            page.handler  = 'erb'
            page.title    = 'Foo/Bar (de)'
          end
        end

        it 'should succeed' do
          get :respond, page: '/foo/bar', locale: 'de'
          response.code.should eq('200')
        end
      end
    end
  end
end
