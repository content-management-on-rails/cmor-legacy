require "rails_helper"

RSpec.describe Cmor::Core::Configuration do
  it { expect(described_class).to respond_to(:default_markup_options) }
  it { expect(described_class).to respond_to(:features) }
end
