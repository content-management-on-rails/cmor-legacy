require 'rails_helper'

describe Cmor::CmsHelper, type: :helper do
  describe '#link_to_top' do
    it { expect(helper.link_to_top).to include('#top') }
  end
end
