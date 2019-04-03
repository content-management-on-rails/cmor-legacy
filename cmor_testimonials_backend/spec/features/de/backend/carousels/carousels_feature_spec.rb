require 'rails_helper'

RSpec.describe '/de/backend/carousels/carousels', type: :feature do
  let(:resource_class) { Cmor::Carousels::Carousel }

  describe 'REST actions' do
    let(:resource) { create(:cmor_carousels_carousel) }
    let(:resources) { create_list(:cmor_carousels_carousel, 3) }

    it { resources; expect(subject).to implement_index_action(self) }

    it { 
      expect(subject).to implement_create_action(self)
        .for(Cmor::Carousels::Carousel)
        .within_form('#new_carousel') {
          select 'de', from: 'carousel[locale]'
          fill_in 'carousel[identifier]', with: 'main'
        }
        .increasing{ Cmor::Carousels::Carousel.count }.by(1)
    }
    
    it { expect(subject).to implement_show_action(self).for(resource) }

    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form('.edit_carousel') {
          fill_in 'carousel[identifier]', with: 'secondary'
        }
        .updating
        .from(resource.attributes)
        .to({ 'identifier' => 'secondary' })
    }

    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing{ resource_class.count }.by(1)
    }
  end

  describe 'appending item details' do
    let(:original_assets) {[
      { io: File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))), filename: 'example.png'},
      { io: File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))), filename: 'example.png'}
    ]}
    let(:resource) { create(:cmor_carousels_carousel, assets: original_assets) }
    let(:base_path) { '/de/backend/carousels/carousels' }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }

    let(:submit_button) { within('form.edit_carousel') { first('input[type="submit"]') } }

    before(:each) do
      visit(edit_path)
      attach_file 'carousel[append_assets][]', [Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))]
    end

    it { expect{ submit_button.click  }.to change{ resource.item_details.count }.from(2).to(3) }
  end

  describe 'replacing item details' do
    let(:original_assets) {[
      { io: File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))), filename: 'example.png'},
      { io: File.open(Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))), filename: 'example.png'}
    ]}
    let(:resource) { create(:cmor_carousels_carousel, assets: original_assets) }
    let(:base_path) { '/de/backend/carousels/carousels' }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }

    let(:submit_button) { within('form.edit_carousel') { first('input[type="submit"]') } }

    before(:each) do
      visit(edit_path)
      attach_file 'carousel[overwrite_assets][]', [Cmor::Carousels::Engine.root.join(*%w(spec files cmor carousels item_details example.png))]
    end

    it { expect{ submit_button.click  }.to change{ resource.item_details.count }.from(2).to(1) }
  end
end
