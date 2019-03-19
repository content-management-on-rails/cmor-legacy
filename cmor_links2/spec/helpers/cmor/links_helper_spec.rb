require 'rails_helper'

module Cmor
  describe LinksHelper do
    describe '#render_link_footer' do
      before(:each) do
        I18n.locale = :en
        @categories = FactoryBot.create_list(:cmor_links_category_for_link_footer, 6, locale: :en)
      end

      subject { helper.render_link_footer }

      it 'should show all category names' do
        @categories.each do |category|
          subject.should have_content(category.name)
        end
      end

      context 'i18n support' do
        before(:each) do
          I18n.locale = :de
          @de_categories = FactoryBot.create_list(:cmor_links_category_for_link_footer, 6, locale: 'de')
          @en_categories = FactoryBot.create_list(:cmor_links_category_for_link_footer, 6, locale: 'en')
        end

        it 'should show category names with the actual locale' do
          @de_categories.each do |category|
            subject.should have_content(category.name)
          end
        end

        it 'should not show category names with a different locale' do
          @en_categories.each do |category|
            subject.should_not include(category.name)
          end
        end
      end
    end
  end
end
