require 'rails_helper'

module Cmor
  module Links
    describe LinksHelper do
      describe '#render_link' do
        before(:each) do
          @link = FactoryBot.create(:cmor_links_link)
        end

        subject { helper.render_link(@link) }

        it { should have_link(@link.name, href: @link.url) }
      end
    end
  end
end
