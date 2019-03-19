require 'rails_helper'

module Cmor::Cms
  describe CreateNavigationService do
    before(:each) do
      items_attributes = [
        { name: 'Home', url: '/de', key: 'home' },
        { name: 'Kontakt', url: '/de/kontakt', key: 'contact' }
      ]
      @options = { locale: I18n.locale, name: 'main', items_attributes: items_attributes }
    end
    it { expect { CreateNavigationService.call(@options) }.to change { Cmor::Cms::Navigation.count }.from(0).to(1) }
    it { expect { CreateNavigationService.call(@options) }.to change { Cmor::Cms::NavigationItem.count }.from(0).to(2) }

    describe 'the new navigation' do
      before(:each) { CreateNavigationService.call(@options) }
      subject { Cmor::Cms::Navigation.first }

      it { expect(subject.locale).to eq("#{I18n.locale}") }
      it { expect(subject.name).to eq('main') }
      it { expect(subject.cmor_cms_navigation_items.count).to eq(2) }
    end

    describe 'the new navigation items' do
      before(:each) { CreateNavigationService.call(@options) }
      subject { Cmor::Cms::NavigationItem.all }

      it { expect(subject.first.name).to eq("Home") }
      it { expect(subject.first.url).to eq("/de") }
      it { expect(subject.first.key).to eq("home") }

      it { expect(subject.last.name).to eq("Kontakt") }
      it { expect(subject.last.url).to eq("/de/kontakt") }
      it { expect(subject.last.key).to eq("contact") }
    end
  end
end
