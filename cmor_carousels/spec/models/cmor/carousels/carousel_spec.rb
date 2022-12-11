require 'rails_helper'

RSpec.describe Cmor::Carousels::Carousel, type: :model do
  describe '#append_item_detail_assets' do
    let(:existing_item_details) { create_list(:cmor_carousels_item_detail, 1, carousel: subject) }
    let(:new_assets) { [{ io: File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))), filename: 'appended.png' }] }

    subject { create(:cmor_carousels_carousel) }

    before(:each) do
      existing_item_details
    end

    describe 'persistence changes' do
      it { expect { subject.append_item_detail_assets = new_assets; subject.save! }.to change { subject.item_details.count }.from(1).to(2) }
    end
  end

  describe '#overwrite_item_detail_assets' do
    let(:existing_item_details) { create_list(:cmor_carousels_item_detail, 2, carousel: subject) }
    let(:new_assets) { [{ io: File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))), filename: 'appended.png' }] }

    subject { create(:cmor_carousels_carousel) }

    before(:each) do
      existing_item_details
    end

    describe 'persistence changes' do
      it { expect { subject.overwrite_item_detail_assets = new_assets; subject.save! }.to change { subject.item_details.count }.from(2).to(1) }
    end
  end
end
