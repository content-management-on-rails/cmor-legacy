require 'rails_helper'

module Cmor
  module Links
    describe Link do
      subject { FactoryBot.create(:cmor_links_link) }

      context 'associations' do
        it { should belong_to(:cmor_links_category) }
      end

      context 'basic validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:url) }
      end

      context 'acts as list' do
        it { should respond_to(:move_to_top) }
        it { should respond_to(:move_higher) }
        it { should respond_to(:move_lower) }
        it { should respond_to(:move_to_bottom) }
      end

      context ' markup' do
        subject do
          FactoryBot.create(:cmor_links_link,
                             description: 'h1. This is a heading'
                            )
        end

        it { should validate_presence_of(:markup_language) }

        %w(textile).each do |value|
          it { should allow_value(value).for(:markup_language) }
        end

        %w(some other values that are not allowed).each do |value|
          it { should_not allow_value(value).for(:markup_language) }
        end

        context 'description.to_html' do
          it { expect(subject.description(as: :html)).to eq('<h1>This is a heading</h1>') }
        end
      end
    end
  end
end
