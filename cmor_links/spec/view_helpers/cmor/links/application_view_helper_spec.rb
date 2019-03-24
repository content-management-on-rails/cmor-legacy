require 'rails_helper'

RSpec.describe Cmor::Links::ApplicationViewHelper, type: :view_helper do
  include ActionView::RecordIdentifier

  describe "render_footer" do
    it { expect(rendered).to have_css(".link-footer") }
  end

  describe "render_category" do
    let(:category) { create(:cmor_links_category) }
    let(:options) { category }

    it { expect(rendered).to have_content(category.name) }
    it { expect(rendered).to have_css("##{dom_id(category)}") }
  end

  describe "render_link" do
    let(:link) { create(:cmor_links_link) }
    let(:options) { link }

    it { expect(rendered).to have_link(link.name, href: link.url) }
  end
end