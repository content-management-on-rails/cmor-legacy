require "rails_helper"

RSpec.describe Cmor::Showcase do
  it { expect(described_class).to be_const_defined("VERSION") }
end
