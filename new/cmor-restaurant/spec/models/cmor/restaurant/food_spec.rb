require "rails_helper"

module Cmor::Restaurant
  RSpec.describe Food, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:category) }
    end

    describe "validations" do
      before(:each) { create(:cmor_restaurant_food) }

      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_presence_of(:name) }

      it { expect(subject).to validate_uniqueness_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:name) }
    end
  end
end
