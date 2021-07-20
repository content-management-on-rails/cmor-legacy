require 'rails_helper'

RSpec.describe '/de/backend/tags/taggings', type: :feature do
  let(:user) { create(:cmor_user_area_user, :authenticable) }
  before(:each) { sign_in(user) }

  let(:tag) { create(:cmor_tags_tag) }

  let(:resource_class) { Cmor::Tags::Tagging }
  let(:resource) { create(:cmor_tags_tagging) }
  let(:resources) { create_list(:cmor_tags_tagging, 3) }

  it { resources; expect(subject).to implement_index_action(self) }

  let(:post) { create(:cmor_blog_post) }

  it {
    tag
    post
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_tagging') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select post.title, from: 'tagging[taggable]'
        select tag.name, from: 'tagging[tag_id]'
        fill_in 'tagging[context]', with: 'default'
      }
      .increasing{ Cmor::Tags::Tagging.count }.by(1)
  }
  
  it { expect(subject).to implement_show_action(self).for(resource) }

  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_tagging') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        fill_in 'tagging[context]', with: 'new-context'
      }
      .updating
      .from(resource.attributes)
      .to({ 'context' => 'new-context' }) # Example: .to({ 'name' => 'New name' })
  }

  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
