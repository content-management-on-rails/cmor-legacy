require 'spec_helper'

describe 'Carousels' do
  def set_resource_class
    @resource_class = Cmor::Carousels::Carousel
  end

  before do
    set_resource_class
    @resource_path = @resource_class.to_s.underscore.gsub('/', '_').pluralize
    @resource_factory_name = @resource_class.to_s.underscore.gsub('/', '_').to_sym
  end # background

  describe 'index' do
    before do
      get "/#{@resource_path}"
    end

    it "request should be successful" do
      response.code.should eq("200")
    end

    it "render the index template" do
      response.should render_template(:index)
    end    
  end
end

