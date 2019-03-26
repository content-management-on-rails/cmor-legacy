require 'rails_helper'

RSpec.describe Cmor::Cms::Page::ContentBlock, type: :model do
  context 'associations' do
    it { expect(subject).to belong_to(:content_box) }
    it { expect(subject).to belong_to(:page) }
  end

  context 'validations' do
    it { expect(subject).to validate_presence_of(:body) }
  end
end
