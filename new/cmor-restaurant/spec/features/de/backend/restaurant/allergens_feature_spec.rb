require "rails_helper"

RSpec.describe "/de/backend/restaurant/allergens", type: :feature do
  let(:resource_class) { Cmor::Restaurant::Allergen }
  let(:resource) { create(:cmor_restaurant_allergen) }
  let(:resources) { create_list(:cmor_restaurant_allergen, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_allergen") {
        fill_in "allergen[name]", with: "Peanuts"
        fill_in "allergen[identifier]", with: "peanuts"
      }
      .increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_allergen") {
        fill_in "allergen[name]", with: "Updated peanuts"
      }
      .updating
      .from(resource.attributes)
      .to({"name" => "Updated peanuts"})
  end

  # Delete
  it do
    resource
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
