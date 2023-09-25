require "rails_helper"

RSpec.describe "/de/backend/bilder/picture_details", type: :feature, locale: :de do
  let(:resource_class) { Cmor::Galleries::PictureDetail }
  let(:resource) { create(:cmor_galleries_picture_detail) }
  let(:resources) { create_list(:cmor_galleries_picture_detail, 3) }

  describe "REST actions" do
    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_picture_detail") {
                           # fill the needed form inputs via capybara here
                           #
                           # Example:
                           #
                           #     fill_in 'slider[name]', with: 'New name'
                           fill_in "picture_detail[title]", with: "A new name"
                         }
        .updating
        .from(resource.attributes)
        .to({"title" => "A new name"}) # Example: .to({ 'name' => 'New name' })
    }

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing { resource_class.count }.by(1)
    }
  end
end
