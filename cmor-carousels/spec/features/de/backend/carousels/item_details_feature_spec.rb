require "rails_helper"

RSpec.describe "/de/backend/karusselle/item_details", type: :feature do
  let(:carousel) { create(:cmor_carousels_carousel) }

  let(:resource_class) { Cmor::Carousels::ItemDetail }
  let(:resource) { create(:cmor_carousels_item_detail) }
  let(:resources) { create_list(:cmor_carousels_item_detail, 3) }

  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  it { expect(subject).to implement_show_action(self).for(resource) }

  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_item_detail") {
        fill_in "item_detail[description]", with: "New body"
      }
      .updating
      .from(resource.attributes)
      .to({"description" => "New body"})
  }

  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
