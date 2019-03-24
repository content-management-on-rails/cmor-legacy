require 'rails_helper'

RSpec.describe Cmor::Cms::CreateNavigationService, type: :model do
  let(:items_attributes) {
    [
      { name: 'Home', url: '/de', key: 'home' },
      { name: 'Kontakt', url: '/de/kontakt', key: 'contact' }
    ]
  }
  let(:options) { { locale: I18n.locale, name: 'main', items_attributes: items_attributes } }

  it { expect { described_class.call(options) }.to change { Cmor::Cms::Navigation.count }.from(0).to(1) }
  it { expect { described_class.call(options) }.to change { Cmor::Cms::NavigationItem.count }.from(0).to(2) }

  describe 'the new navigation' do
    subject { Cmor::Cms::Navigation.first }

    before(:each) { described_class.call(options) }

    it { expect(subject.locale).to eq("#{I18n.locale}") }
    it { expect(subject.name).to eq('main') }
    it { expect(subject.cmor_cms_navigation_items.count).to eq(2) }
  end

  describe 'the new navigation items' do
    subject { Cmor::Cms::NavigationItem.all }
    
    before(:each) { described_class.call(options) }

    it { expect(subject.first.name).to eq("Home") }
    it { expect(subject.first.url).to eq("/de") }
    it { expect(subject.first.key).to eq("home") }

    it { expect(subject.last.name).to eq("Kontakt") }
    it { expect(subject.last.url).to eq("/de/kontakt") }
    it { expect(subject.last.key).to eq("contact") }
  end
end