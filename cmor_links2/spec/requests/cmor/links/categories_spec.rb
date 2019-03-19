require 'rails_helper'

describe 'Cmor::Links::Category requests' do
  def set_resource_class
    @resource_class = Cmor::Links::Category
  end

  before do
    set_resource_class
    @resource_path = @resource_class.to_s.underscore.tr('/', '_').pluralize
    @resource_factory_name = @resource_class.to_s.underscore.tr('/', '_').to_sym
  end # background

  describe 'show' do
    before do
      @resource = FactoryBot.create(@resource_factory_name)
      get "/#{@resource_path}/#{@resource.to_param}"
    end

    it 'request should be successful' do
      response.code.should eq('200')
    end

    it 'render the show template' do
      response.should render_template(:show)
    end
  end

  describe 'index' do
    before do
      get "/#{@resource_path}"
    end

    it 'request should be successful' do
      response.code.should eq('200')
    end

    it 'render the index template' do
      response.should render_template(:index)
    end
  end
end
