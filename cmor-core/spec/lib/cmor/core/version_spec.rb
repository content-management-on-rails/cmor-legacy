require "rails_helper"

RSpec.describe Cmor::Core::VERSION do
  it { expect(Cmor::Core::VERSION).to be_a(String) }
  it { expect(Cmor::Core::VERSION).to eq Cmor::VERSION }
end
