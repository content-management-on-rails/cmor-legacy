require "rails_helper"

module Cmor::Restaurant
  RSpec.describe FoodAdditive, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:food) }
      it { expect(subject).to belong_to(:additive) }
    end
  end
end
