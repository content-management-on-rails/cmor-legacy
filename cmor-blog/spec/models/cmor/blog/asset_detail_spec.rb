require 'rails_helper'

RSpec.describe Cmor::Blog::AssetDetail, type: :model do
  describe "scopes" do
    it { expect(described_class).to respond_to(:images) }
    it { expect(described_class).to respond_to(:non_images) }
  end
end
