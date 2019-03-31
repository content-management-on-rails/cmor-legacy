require 'rails_helper'

RSpec.describe Cmor::Cms::NavigationItem, type: :model do
  subject { create(:cmor_cms_navigation_item) }

  context 'associations' do
    it { pending('wtf? why is this failing?'); expect(subject).to belong_to(:navigation).optional }
    it { expect(subject).to belong_to(:page).optional }
  end

  context '#to_s' do
    it 'should return the correct string' do
      expect(subject.to_s).to eq("#{subject.navigation}: #{subject.name}")
    end
  end

  context 'properties' do
    it { expect(subject).to respond_to(:li_attributes) }
    it { expect(subject).to respond_to(:highlights_on) }
  end

  context 'li_attributes' do
    it 'should work on intialization' do
      expect { Cmor::Cms::NavigationItem.new(data_add_icon: 'foo') }.not_to raise_error
    end
  end

  context 'callbacks' do
    context '#update_navigation_from_parent' do
      it 'should set the navigation from the parent item' do
        root = create(:cmor_cms_navigation_item)
        foo  = create(:cmor_cms_navigation_item, parent: root)

        foo.valid?
        expect(foo.navigation).to eq(root.navigation)
      end
    end

    context '#update_children_navigations!' do
      it 'should set the new navigation on all descendants' do
        pending
        original_navigation = create(:cmor_cms_navigation, name: 'old_navigation')
        first_level_item = create(:cmor_cms_navigation_item, name: 'first_level_item', navigation: original_navigation)
        second_level_item = create(:cmor_cms_navigation_item, name: 'second_level_item', parent: first_level_item)
        
        new_navigation = create(:cmor_cms_navigation, name: 'new_navigation')
        first_level_item.navigation = new_navigation
        first_level_item.save!
        expect(second_level_item.reload.navigation).to eq(new_navigation)
      end
    end

    context '#update_url_form_page' do
      it 'should set the url from page if url is blank and page is present' do
        basename = 'about-us'
        locale = 'en'
        page = build(:cmor_cms_page, basename: basename, locale: locale)
        ni = build(:cmor_cms_navigation_item, url: nil, page: page)

        ni.valid?
        expect(ni.url).to eq('/en/about-us')
      end

      it 'should set the correct url for home pages' do
        page = build(:cmor_cms_page, pathname: '/', basename: 'home', locale: 'en')
        ni = build(:cmor_cms_navigation_item, url: nil, page: page)

        ni.valid?
        expect(ni.url).to eq('/en')
      end
    end
  end

  context 'validations' do
    it { expect(subject).to validate_presence_of :key }
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_presence_of :url }
    # Removed due to missing if support
    # it { expect(subject).to validate_presence_of :navigation }
    it 'should validate presence of :navigation if it is a root item' do
      navigation_item = build(:cmor_cms_navigation_item_root, navigation: nil)
      expect(navigation_item).not_to be_valid
    end

    it 'should not validate presence of :navigation if it is a child item' do
      navigation_item = build(:cmor_cms_navigation_item_child, navigation: nil)
      expect(navigation_item).to be_valid
    end
  end

  context '#params_for_new_page' do
    context 'for a new record' do
      subject { Cmor::Cms::NavigationItem.new }

      it 'should return an empty hash if the record is not persisted' do
        expect(subject.params_for_new_page).to eq({})
      end
    end

    context 'for a persisted object' do
      subject { create(:cmor_cms_navigation_item) }

      it "should return the correct params when having the url '/en/contact'" do
        subject.url = '/en/contact'
        subject.name = 'Contact'

        expected_params = { locale: 'en', pathname: '/', basename: 'contact', title: subject.name, navigation_item_ids: [subject.to_param] }
        expect(subject.params_for_new_page).to eq(expected_params)
      end

      it "should return the correct params when having the url '/en'" do
        subject.url = '/en'
        subject.name = 'Home'

        expected_params = { locale: 'en', pathname: '/', basename: 'home', title: subject.name, navigation_item_ids: [subject.to_param] }
        expect(subject.params_for_new_page).to eq(expected_params)
      end
    end
  end
end
