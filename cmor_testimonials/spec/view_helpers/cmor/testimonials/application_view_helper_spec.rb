require 'rails_helper'

RSpec.describe Cmor::Testimonials::ApplicationViewHelper, type: :view_helper do
  let(:testimonials) { create_list(:cmor_testimonials_testimonial, 3) }
  let(:category) { create(:cmor_testimonials_category, testimonials: testimonials) }
  let(:args) { [category.identifier, {}] }
  before(:each) do
    register_view_helper Cmor::Core::MarkupViewHelper, as: :markup_helper
  end

  
  describe 'render_category' do
    it { expect(rendered).to have_css('div.cmor-testimonials-category') }
  end
end