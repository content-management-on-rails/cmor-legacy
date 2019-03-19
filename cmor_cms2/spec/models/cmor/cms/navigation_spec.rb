require 'rails_helper'

module Cmor
  module Cms
    describe Navigation do
      subject { FactoryBot.create :cmor_cms_navigation }

      context 'associations' do
        it { should have_many :cmor_cms_navigation_items }
      end

      context 'public methods' do
        context '#to_s' do
          it 'should have the correct format' do
            subject.locale = 'en'
            subject.name = 'foo'
            subject.to_s.should eq('foo (en)')
          end
        end
      end

      context 'validations' do
        it { should validate_presence_of :name }
        it { should validate_uniqueness_of(:name).scoped_to(:locale) }
        it { should validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
      end
    end
  end
end
