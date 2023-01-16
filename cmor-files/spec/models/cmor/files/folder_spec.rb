require "rails_helper"

module Cmor::Files
  RSpec.describe Folder, type: :model do
    describe "validations" do
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_uniqueness_of(:name).scoped_to([:locale]) }
    end

    describe "file details" do
      it { expect(subject).to respond_to(:file_details_count) }
      it { expect(subject).to respond_to(:append_file_detail_assets=) }
      it { expect(subject).to respond_to(:append_file_detail_assets) }
      it { expect(subject).to respond_to(:overwrite_file_detail_assets=) }
      it { expect(subject).to respond_to(:overwrite_file_detail_assets) }
    end
  end
end
