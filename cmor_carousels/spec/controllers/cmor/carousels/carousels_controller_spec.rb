require 'spec_helper'

module Cmor
  module Carousels
    describe CarouselsController do
      describe "GET index" do
        before(:each) do
          @carousels = FactoryBot.create_list(:cmor_carousels_carousel, 2)
        end
        
        it "has a 200 status code" do
          get :index
          response.code.should eq("200")
        end

        it "assigns all cmor_carousels_carousels to @carousels" do
          get :index
          assigns(:carousels).should eq(@carousels)
        end
      end
    end
  end
end
