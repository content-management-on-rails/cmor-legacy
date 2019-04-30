require 'rails_helper'

RSpec.describe Cmor::Testimonials::ApplicationViewHelper, type: :view_helper do
  let(:category) { create(:cmor_testimonials_category, testimonials: testimonials) }
  let(:args) { [category.identifier, {}] }

  before(:each) do
    register_view_helper Markup::Rails::ApplicationViewHelper, as: :markup_helper
  end
  
  context 'testimonials present' do
    let(:testimonials) { create_list(:cmor_testimonials_testimonial, 3) }

    describe 'render_category' do
      it { expect(html).to have_css('div.cmor-testimonials-category') }
    end
  end

  context 'testimonials absent' do
    let(:testimonials) {[]}

    describe 'render_category' do
      it { expect(rendered).to eq(nil) }
    end
  end
end