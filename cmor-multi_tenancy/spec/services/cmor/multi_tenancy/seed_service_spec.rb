require "rails_helper"

RSpec.describe Cmor::MultiTenancy::SeedService do
  describe "basic usage" do
    subject { described_class.new }
    it { expect(subject.perform).to be_a(Cmor::MultiTenancy::SeedService::Result) }

    describe "changes" do
      it { expect { subject.perform }.to change { Cmor::MultiTenancy::Client.count }.from(0).to(1) }
    end
  end
end
