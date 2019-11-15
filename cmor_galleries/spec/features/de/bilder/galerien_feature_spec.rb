require 'rails_helper'

RSpec.describe '/de/bilder/galerien', type: :feature do
  let(:resource_class) { Cmor::Galleries::PictureGallery }
  let(:resource) { create(:cmor_galleries_picture_gallery, published: true) }
  let(:resources) { create_list(:cmor_galleries_picture_gallery, 3, published: true) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }
end
