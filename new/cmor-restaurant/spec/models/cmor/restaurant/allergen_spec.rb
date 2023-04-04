require "rails_helper"

module Cmor::Restaurant
  RSpec.describe Allergen, type: :model do
    describe "associations" do
      it { expect(subject).to have_many(:food_allergens) }
      it { expect(subject).to have_many(:foods).through(:food_allergens) }
    end

    describe "validations" do
      before(:each) { create(:cmor_restaurant_additive) }

      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_presence_of(:name) }

      it { expect(subject).to validate_uniqueness_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:name) }
    end
  end
end
