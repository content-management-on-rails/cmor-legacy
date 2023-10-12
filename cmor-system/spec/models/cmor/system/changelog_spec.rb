require "rails_helper"

RSpec.describe Cmor::System::Changelog, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:file) }
  it { expect(subject).to respond_to(:gem) }
  it { expect(subject).to respond_to(:name) }
  it { expect(subject).to respond_to(:version) }

  describe "self.all" do
    subject { described_class.all }
    it { expect(subject).to be_a(Array) }
  end

  describe "self.first" do
    subject { described_class.first }
    it { expect(subject).to eq(described_class.all.first) }
  end

  describe "self.find" do
    context "with an existing gem" do
      subject { described_class.find("activemodel") }
      it { expect(subject).to be_a(described_class) }
    end

    context "with a missing gem" do
      subject { described_class.find("missing") }
      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "self.count" do
    subject { described_class.count }
    it { expect(subject).to eq(described_class.all.size) }
  end
end
