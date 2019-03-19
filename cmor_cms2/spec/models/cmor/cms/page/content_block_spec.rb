require 'rails_helper'

module Cmor::Cms
  describe Page::ContentBlock do
    context 'associations' do
      it { should belong_to :cmor_cms_content_box }
      it { should belong_to :cmor_cms_page }
    end

    context 'validations' do
      it { should validate_presence_of :body }
      it { should validate_presence_of :cmor_cms_content_box }
      it { should validate_presence_of :cmor_cms_page }
    end
  end
end
