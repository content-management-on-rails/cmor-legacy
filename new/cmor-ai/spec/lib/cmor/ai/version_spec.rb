# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Ai do
  it { expect(described_class).to be_const_defined("VERSION") }
end
