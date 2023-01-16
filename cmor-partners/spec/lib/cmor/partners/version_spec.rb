require "rails_helper"

RSpec.describe Cmor::Partners do
  it { expect(described_class).to be_const_defined("VERSION") }
end
