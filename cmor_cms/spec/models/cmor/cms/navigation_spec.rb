require 'rails_helper'

RSpec.describe Cmor::Cms::Navigation, type: :model do
  subject { create(:cmor_cms_navigation) }

  context 'associations' do
    it { expect(subject).to have_many :navigation_items }
  end

  context 'public methods' do
    context '#human' do
      it 'should have the correct format' do
        subject.locale = 'en'
        subject.name = 'foo'
        expect(subject.human).to eq('foo (en)')
      end
    end
  end

  context 'validations' do
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_uniqueness_of(:name).scoped_to(:locale) }
    it { expect(subject).to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
  end
end
