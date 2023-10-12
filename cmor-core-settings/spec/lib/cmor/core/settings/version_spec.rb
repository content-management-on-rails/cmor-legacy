require "rails_helper"

RSpec.describe Cmor::Core::Settings do
  it { expect(described_class::VERSION).to be_a(String) }
  it { expect(described_class::VERSION).to eq Cmor::VERSION }
end
