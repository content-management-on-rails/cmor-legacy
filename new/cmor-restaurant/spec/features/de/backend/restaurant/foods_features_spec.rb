require "rails_helper"

RSpec.describe "/de/backend/restaurant/foods", type: :feature do
  let(:resource_class) { Cmor::Restaurant::Food }
  let(:resource) { create(:cmor_restaurant_food) }
  let(:resources) { create_list(:cmor_restaurant_food, 3) }

  let(:category) { create(:cmor_restaurant_category) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    category
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_food") {
        select category.name, from: "food[category_id]"
        fill_in "food[name]", with: "Bottle of water"
        fill_in "food[identifier]", with: "bottle-of-water"
        fill_in "food[price]", with: "3,50"
        fill_in "food[quantity]", with: "750"
        fill_in "food[unit]", with: "ml"
      }
      .increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_food") {
        fill_in "food[name]", with: "My updated food"
        fill_in "food[description]", with: "An updated description of my food"
      }
      .updating
      .from(resource.attributes)
      .to({"name" => "My updated food", "description" => "An updated description of my food"})
  end

  # Delete
  it do
    resource
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
