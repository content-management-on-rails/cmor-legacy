require 'rails_helper'

RSpec.describe '/de/backend/dateien/folders', type: :feature do
  let(:user) { create(:cmor_user_area_user, :authenticable) }
  before(:each) { sign_in(user) }

  let(:resource_class) { Cmor::Files::Folder }

  describe 'REST actions' do
    let(:resource) { create(:cmor_files_folder) }
    let(:resources) { create_list(:cmor_files_folder, 3) }

    # List
    it { resources; expect(subject).to implement_index_action(self) }

    # Create
    it { 
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form('#new_folder') {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     select 'de', from: 'slider[locale]'
          #     fill_in 'slider[name]', with: 'My first slider'
          #     check 'slider[auto_start]'
          #     fill_in 'slider[interval]', with: '3'
          fill_in 'folder[name]',        with: 'My first folder'
          fill_in 'folder[description]', with: 'There are awsome files in here!'
        }
        .increasing{ Cmor::Files::Folder.count }.by(1)
    }
    
    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form('.edit_folder') {
          # fill the needed form inputs via capybara here
          # 
          # Example:
          # 
          #     fill_in 'slider[name]', with: 'New name'
          fill_in 'folder[name]', with: 'Awesome files folder'
        }
        .updating
        .from(resource.attributes)
        .to({ 'name' => 'Awesome files folder' }) # Example: .to({ 'name' => 'New name' })
    }

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing{ resource_class.count }.by(1)
    }
  end

  describe 'appending item details' do
    let(:original_assets) {[
      { io: File.open(Cmor::Files::Engine.root.join(*%w(spec files cmor files file_details example.png))), filename: 'example.png'},
      { io: File.open(Cmor::Files::Engine.root.join(*%w(spec files cmor files file_details example.png))), filename: 'example.png'}
    ]}
    let(:resource) { create(:cmor_files_folder, assets: original_assets) }
    let(:base_path) { '/de/backend/dateien/folders' }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }

    let(:submit_button) { within('form.edit_folder') { first('input[type="submit"]') } }

    before(:each) do
      visit(edit_path)
      attach_file 'folder[append_assets][]', [Cmor::Files::Engine.root.join(*%w(spec files cmor files file_details example.png))]
    end

    it { expect{ submit_button.click }.to change{ resource.file_details.count }.from(2).to(3) }
  end

  describe 'replacing item details' do
  let(:original_assets) {[
      { io: File.open(Cmor::Files::Engine.root.join(*%w(spec files cmor files file_details example.png))), filename: 'example.png'},
      { io: File.open(Cmor::Files::Engine.root.join(*%w(spec files cmor files file_details example.png))), filename: 'example.png'}
    ]}
    let(:resource) { create(:cmor_files_folder, assets: original_assets) }
    let(:base_path) { '/de/backend/dateien/folders' }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }

    let(:submit_button) { within('form.edit_folder') { first('input[type="submit"]') } }

    before(:each) do
      visit(edit_path)
      attach_file 'folder[overwrite_assets][]', [Cmor::Files::Engine.root.join(*%w(spec files cmor files file_details example.png))]
    end

    it { expect{ submit_button.click }.to change{ resource.file_details.count }.from(2).to(1) }
  end
end
