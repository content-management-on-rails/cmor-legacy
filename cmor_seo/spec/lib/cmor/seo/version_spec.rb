require 'rails_helper'

RSpec.describe Cmor::Seo do
  it { expect(described_class).to be_const_defined('VERSION') }
end