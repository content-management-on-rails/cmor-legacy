require "rails_helper"

RSpec.describe "/de/backend/restaurant/additives", type: :feature do
  let(:resource_class) { Cmor::Restaurant::Additive }
  let(:resource) { create(:cmor_restaurant_additive) }
  let(:resources) { create_list(:cmor_restaurant_additive, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_additive") {
        fill_in "additive[name]", with: "Red food coloring"
        fill_in "additive[identifier]", with: "red-coloring"
      }
      .increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_additive") {
        fill_in "additive[name]", with: "Updated red food coloring"
        fill_in "additive[identifier]", with: "updated-red-coloring"
      }
      .updating
      .from(resource.attributes)
      .to({"name" => "Updated red food coloring", "identifier" => "updated-red-coloring"})
  end

  # Delete
  it do
    resource
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
