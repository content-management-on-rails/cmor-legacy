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
      create(:cmor_links_link, description: 'h1. This is a heading')
    end

    it { expect(subject).to validate_presence_of(:markup_language) }

    %w(textile).each do |value|
      it { expect(subject).to allow_value(value).for(:markup_language) }
    end

    %w(some other values that are not allowed).each do |value|
      it { expect(subject).not_to allow_value(value).for(:markup_language) }
    end

    context 'description.to_html' do
      it { expect(subject.description(as: :html)).to eq('<h1>This is a heading</h1>') }
    end
  end
end
