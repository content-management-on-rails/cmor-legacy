require 'rails_helper'

RSpec.describe Cmor::Cms::Page::ContentBlock, type: :model do
  context 'associations' do
    it { expect(subject).to belong_to(:cmor_cms_content_box) }
    it { expect(subject).to belong_to(:cmor_cms_page) }
  end

  context 'validations' do
    it { expect(subject).to validate_presence_of(:body) }
    it { expect(subject).to validate_presence_of(:cmor_cms_content_box) }
    it { expect(subject).to validate_presence_of(:cmor_cms_page) }
  end
end
