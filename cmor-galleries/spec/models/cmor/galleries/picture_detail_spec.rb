require "rails_helper"

module Cmor::Galleries
  RSpec.describe PictureDetail, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:picture_gallery) }
    end

    describe "validations" do
      it { expect(subject).to validate_uniqueness_of(:identifier) }
    end
  end
end
