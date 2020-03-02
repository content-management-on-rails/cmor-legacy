require 'rails_helper'

RSpec.describe Cmor::Legal::Configuration do
  it { expect(subject).to respond_to(:cookies=) }
  it { expect(subject).to respond_to(:cookies) }
  
  describe '#cookies=' do
    subject {  ::Cmor::Legal::CookiePreferences.new(cookie_store: ::Cmor::Legal::CookieStore.new({})) }

    around(:each) do |example|
      @original = Cmor::Legal::Configuration.cookies
      example.run
      Cmor::Legal::Configuration.cookies = @original
    end

    before(:each) do
      Cmor::Legal.configure do |config|
        config.cookies = ->(cookie_store = Cmor::Legal::CookieStore.new({})) {
          [
            Cmor::Legal::Cookie.new(
              identifier: :analytics,
              adjustable: true,
              default: false,
              cookie_store: cookie_store,
              allowed_cookies: [
                { name: "_ga", domain: ".example.com", expiry: 2.years, description: { de: "Google Analytics: Wird benutzt um Nutzungsstatistiken zu erstellen.", en: "Google Analytics: Used to distinguish users." }, url: "https://developers.google.com/analytics/devguides/collection/analyticsjs/cookie-usage"  }
              ]
            )
          ]
        }
      end
    end

    it { expect(subject.cookies).to respond_to(:each) }
    it { expect(subject.cookies.size).to eq(1) }
    

    describe 'cookies' do
      subject { ::Cmor::Legal::CookiePreferences.new(cookie_store: ::Cmor::Legal::CookieStore.new({})).cookies.first }

      it { expect(subject.identifier).to eq(:analytics) }
      it { expect(subject.allowed_cookies).to respond_to(:each) }

      describe 'allowed_cookies' do
        subject { ::Cmor::Legal::CookiePreferences.new(cookie_store: ::Cmor::Legal::CookieStore.new({})).cookies.first.allowed_cookies }
        
        it { expect(subject.first).to be_a(Cmor::Legal::AllowedCookie) }
      end
    end
  end
end