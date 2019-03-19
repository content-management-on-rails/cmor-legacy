require 'rails_helper'

module Cmor
  module Links
    describe CategoriesHelper do
      describe '#render_link_category' do
        before(:each) do
          @category = FactoryBot.create(:cmor_links_category)
        end

        subject { helper.render_link_category(@category) }

        it { should have_content(@category.name) }
      end
    end
  end
end
