require 'rails_helper'

RSpec.describe Cmor::Links::Link, type: :model do
  subject { create(:cmor_links_link) }

  context 'associations' do
    it { expect(subject).to belong_to(:category).optional }
  end

  context 'basic validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:url) }
  end

  context 'acts as list' do
    it { expect(subject).to respond_to(:move_to_top) }
    it { expect(subject).to respond_to(:move_higher) }
    it { expect(subject).to respond_to(:move_lower) }
    it { expect(subject).to respond_to(:move_to_bottom) }
  end

  context 'markup' do
    subject do
      create(:cmor_links_link, description: '# This is a heading')
    end

    context 'description.to_html' do
      it { expect(subject.description(:html)).to eq("<h1 id=\"this-is-a-heading\">This is a heading</h1>\n") }
    end
  end
end
