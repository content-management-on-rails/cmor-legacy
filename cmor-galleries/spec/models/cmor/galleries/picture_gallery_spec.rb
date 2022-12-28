require "rails_helper"

module Cmor::Galleries
  RSpec.describe PictureGallery, type: :model do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_uniqueness_of(:name).scoped_to([:locale]) }
  end
end
