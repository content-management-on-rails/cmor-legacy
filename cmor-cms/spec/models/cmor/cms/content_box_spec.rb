require "rails_helper"

RSpec.describe Cmor::Cms::ContentBox, type: :model do
  context "associations" do
    it { expect(subject).to have_many(:content_blocks) }
  end

  context "validations" do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_uniqueness_of(:name) }
  end
end
