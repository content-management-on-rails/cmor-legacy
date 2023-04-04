require "rails_helper"

module Cmor::Restaurant
  RSpec.describe FoodAllergen, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:food) }
      it { expect(subject).to belong_to(:allergen) }
    end
  end
end
