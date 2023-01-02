# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Legal::Cookie, type: :model do
  it { expect(subject).to be_a(described_class) }

  describe "boolean conversions" do
    ["true", true, "1", 1].each do |value|
      it { expect(described_class.new(value: value).value).to eq(true) }
    end

    ["false", false, "0", 0, nil].each do |value|
      it { expect(described_class.new(value: value).value).to eq(false) }
    end
  end

  describe "default value from configuration" do
    describe "when false" do
      before(:each) do
        ::Cmor::Legal::Configuration.cookies = ->(cookie_store = nil) {
          [::Cmor::Legal::Cookie.new(identifier: :basic, adjustable: true, default: false, cookie_store: cookie_store)]
        }
      end

      it { expect(described_class.first.value).to eq(false) }
    end

    describe "when true" do
      before(:each) do
        ::Cmor::Legal::Configuration.cookies = ->(cookie_store = nil) {
          [::Cmor::Legal::Cookie.new(identifier: :basic, adjustable: true, default: true, cookie_store: cookie_store)]
        }
      end

      it { expect(described_class.first.value).to eq(true) }
    end
  end

  describe "value from cookie store is used over default" do
    let(:cookie_store) { ::Cmor::Legal::CookieStore.new({"#{Cmor::Legal::Configuration.cookie_prefix}basic" => false}) }
    describe "when false" do
      before(:each) do
        ::Cmor::Legal::Configuration.cookies = ->(cookie_store = nil) {
          [::Cmor::Legal::Cookie.new(identifier: :basic, adjustable: true, default: true, cookie_store: cookie_store)]
        }
      end

      it { expect(described_class.first(cookie_store).value).to eq(false) }
    end

    describe "when true" do
      let(:cookie_store) { ::Cmor::Legal::CookieStore.new({"#{Cmor::Legal::Configuration.cookie_prefix}basic" => true}) }
      before(:each) do
        ::Cmor::Legal::Configuration.cookies = ->(cookie_store = nil) {
          [::Cmor::Legal::Cookie.new(identifier: :basic, adjustable: true, default: false, cookie_store: cookie_store)]
        }
      end

      it { expect(described_class.first(cookie_store).value).to eq(true) }
    end
  end
end
