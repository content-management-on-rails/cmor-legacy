require 'spec_helper'

module Cmor
  describe CarouselsHelper do
    describe "#render_carousel" do
      context "basic behaviour" do
        before(:each) do
          @carousel = FactoryBot.create(:cmor_carousels_carousel_with_items)
        end

        subject { helper.render_carousel(@carousel.name) }

        it "should include the body of all items" do
          @carousel.cmor_carousels_items.each do |item|
            subject.should have_content(item.body)
          end
        end
      end

      context "uses carousel without locale if there is no better" do
        before(:each) do
          @carousel = FactoryBot.create(:cmor_carousels_carousel_with_items, :locale => nil)
        end

        subject { helper.render_carousel(@carousel.name) }

        it "should include the body of all items" do
          @carousel.cmor_carousels_items.each do |item|
            subject.should have_content(item.body)
          end
        end
      end
    end
  end
end

