require 'rails_helper'

RSpec.describe Cmor::Testimonials::TestimonialsBox, type: :model do
  let!(:category) { create :cmor_testimonials_category }
  let!(:testimonials) { create_list(:cmor_testimonials_testimonial, 3, category: category) }

  it { should validate_presence_of :category_identifier }

  describe "#testimonials" do
    subject { described_class.new({ context: ApplicationController, category_identifier: category.identifier })}

    it { expect(subject.testimonials.count).to eq(testimonials.count) }
  end

  # describe "#render" do
  #   subject { described_class.new({ context: ApplicationController, category_identifier: category.identifier })}

  #   it { expect(subject.render).to eq("foo") }
  # end
end
