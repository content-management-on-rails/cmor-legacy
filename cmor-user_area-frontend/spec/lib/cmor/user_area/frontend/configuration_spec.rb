require "rails_helper"

RSpec.describe Cmor::UserArea::Frontend::Configuration do
  subject { described_class }

  it { expect(subject).to respond_to(:base_controller) }
  it { expect(subject).to respond_to(:after_sign_in_url) }
  it { expect(subject).to respond_to(:after_sign_out_url) }
end
