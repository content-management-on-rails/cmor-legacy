require 'rails_helper'

module Cmor
  module Links
    describe Category do
      subject { FactoryBot.create(:cmor_links_category) }

      it { should respond_to :human }

      context 'associations' do
        it { should have_many(:cmor_links_links) }
      end

      context 'basic validations' do
        it { should validate_presence_of(:name) }
        it { should validate_uniqueness_of(:name).scoped_to(:parent_id) }
      end

      context 'acts as markup' do
        subject do
          FactoryBot.create(:cmor_links_category,
                             short_description: 'h1. This is a heading',
                             long_description: 'h1. This is a heading'
                            )
        end

        it { should validate_presence_of(:markup_language) }

        %w(textile).each do |value|
          it { should allow_value(value).for(:markup_language) }
        end

        %w(some other values that are not allowed).each do |value|
          it { should_not allow_value(value).for(:markup_language) }
        end

        context 'short_description.to_html' do
          it { expect(subject.short_description(as: :html)).to eq('<h1>This is a heading</h1>') }
        end

        context 'long_description.to_html' do
          it { expect(subject.long_description(as: :html)).to eq('<h1>This is a heading</h1>') }
        end
      end

      context 'acts as tree' do
        it { should respond_to(:root) }

        it 'should require a locale if it is a root node' do
          subject.locale = nil
          subject.should_not be_valid
        end

        it 'should not accept a locale if it is not a root node' do
          product_category = FactoryBot.create(:cmor_links_category_with_parent)
          product_category.locale = 'en'
          product_category.should_not be_valid
        end
      end

      context 'friendly id' do
        subject { FactoryBot.create(:cmor_links_category, name: 'Look, a slugged category!') }

        it { expect(subject.to_param).to eq('look-a-slugged-category') }
      end
    end
  end
end
