require "rails_helper"

module Cmor::Galleries
  RSpec.describe PictureGallery, type: :model do
    describe "associations" do
      it { expect(subject).to have_many(:picture_details) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_uniqueness_of(:name).scoped_to([:locale]) }
    end
  end
end
