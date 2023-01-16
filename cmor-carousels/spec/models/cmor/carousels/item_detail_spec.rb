require "rails_helper"

RSpec.describe Cmor::Carousels::ItemDetail, type: :model do
  subject { create :cmor_carousels_item_detail }

  context "acts as list" do
    it { should respond_to(:move_to_top) }
    it { should respond_to(:move_higher) }
    it { should respond_to(:move_lower) }
    it { should respond_to(:move_to_bottom) }
  end

  context "associations" do
    it { should belong_to :carousel }
  end

  context "active_storage" do
    it { should respond_to :asset }
  end
end
