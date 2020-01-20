# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Cms::NavigationViewHelper, type: :view_helper do
  before(:each) do
    view.singleton_class.send(:include, SimpleNavigation::Helpers)
  end

  context 'with a missing navigation' do
    describe "render" do
      let(:args) { [:main, {}] }

      it { expect(rendered).to eq("Navigation main (de) nicht gefunden") }
    end
  end

  context 'with a navigation without items' do
    describe "render" do
      let(:navigation) { create(:cmor_cms_navigation) }
      let(:args) { [navigation.name.to_sym, {}] }

      it { expect(rendered).to eq("Navigation #{navigation.name} (#{I18n.locale}) ist leer") }
    end
  end

  context 'with a navigation with published items', pending: 'This should return the navigation html but somehow it does not' do
    describe "render" do
      let(:navigation) { create(:cmor_cms_navigation, name: 'main') }
      let(:navigation_items) { create_list(:cmor_cms_navigation_item, 3, navigation_id: navigation.id, published: true)}
      let(:args) { [navigation.name.to_sym, {}] }

      before(:each) { navigation_items }

      it { expect(rendered).not_to be_nil }
    end
  end

  context 'with a navigation with unpublished items' do
    describe "render" do
      let(:navigation) { create(:cmor_cms_navigation, name: 'main') }
      let(:navigation_items) { create_list(:cmor_cms_navigation_item, 3, navigation_id: navigation.id, published: false)}
      let(:args) { [navigation.name.to_sym, {}] }

      before(:each) { navigation_items }

      it { expect(rendered).to eq("Navigation #{navigation.name} (#{I18n.locale}) ist leer") }
    end
  end
end
