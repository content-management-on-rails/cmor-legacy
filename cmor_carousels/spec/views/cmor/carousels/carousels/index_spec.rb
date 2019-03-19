require 'spec_helper'

describe "cmor/carousels/carousels/index" do
  def add_controller_helpers *controllers
    controllers.each { |c| view.singleton_class.class_eval { include c.new._helpers } }
  end

  before do
    add_controller_helpers ApplicationController
  end
  
  it "renders _carousel partial for each carousel" do
    @carousels = FactoryBot.create_list(:cmor_carousels_carousel, 2)
    assign(:carousels, @carousels)
    render
    @carousels.map(&:cmor_carousels_items).flatten.each do |item| 
      rendered.should have_content(mu(item, :body))
    end  
  end
end
