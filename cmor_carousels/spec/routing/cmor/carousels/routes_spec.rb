require 'spec_helper'

describe "routing to carousels" do
  it "routes /cmor_carousels_carousels to index" do
    expect(:get => "/cmor_carousels_carousels").to route_to(
      :controller => "cmor/carousels/carousels",
      :action => "index"
    )
  end # it
end

