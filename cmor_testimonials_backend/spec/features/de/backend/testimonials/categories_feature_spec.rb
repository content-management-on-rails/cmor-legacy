require 'rails_helper'

RSpec.describe '/de/backend/testimonials/categories', type: :feature do
  let(:resource_class) { Cmor::Testimonials::Category }

  describe 'REST actions' do
    let(:resource) { create(:cmor_testimonials_category)}
    let(:resources) { create_list(:cmor_testimonials_category, 3)}

    it { expect(subject).to implement_index_action(self) }
    it { expect(subject).to implement_show_action(self).for(resource) }

    it { 
      expect(subject).to implement_create_action(self)
        .for(Cmor::Testimonials::Category)
        .within_form('#new_category') {
          select I18n.locale, from: 'category[locale]'
          fill_in 'category[name]', with: 'Example Category #1'
          fill_in 'category[identifier]', with: 'category-1'
        }
        .increasing { Cmor::Testimonials::Category.count }.by(1)
    }

    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form('.edit_category') {
          fill_in 'category[identifier]', with: 'another_example'
        }
        .updating
        .from(resource.attributes)
        .to({ 'identifier' => 'another_example' })
    }

    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing{ resource_class.count }.by(1)
    } 
  end
end