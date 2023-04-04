require "rails_helper"

RSpec.describe "/de/backend/restaurant/categories", type: :feature do
  let(:resource_class) { Cmor::Restaurant::Category }
  let(:resource) { create(:cmor_restaurant_category) }
  let(:resources) { create_list(:cmor_restaurant_category, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_category") {
        fill_in "category[name]", with: "My category"
        fill_in "category[identifier]", with: "my-category"
      }
      .increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_category") {
        fill_in "category[name]", with: "My new category"
        fill_in "category[identifier]", with: "my-new-category"
      }
      .updating
      .from(resource.attributes)
      .to({"name" => "My new category", "identifier" => "my-new-category"})
  end

  # Delete
  it do
    resource
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
