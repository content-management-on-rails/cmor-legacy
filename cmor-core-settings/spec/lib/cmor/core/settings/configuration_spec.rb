require "rails_helper"

RSpec.describe Cmor::Core::Settings::Configuration do
  it { expect(described_class).to respond_to(:store) }
end
