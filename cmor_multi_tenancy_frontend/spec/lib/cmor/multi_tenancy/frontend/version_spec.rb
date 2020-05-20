require 'rails_helper'

RSpec.describe Cmor::MultiTenancy::Frontend do
  it { expect(described_class).to be_const_defined('VERSION') }
end