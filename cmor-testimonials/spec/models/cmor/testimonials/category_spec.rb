require "rails_helper"

RSpec.describe Cmor::Testimonials::Category, type: :model do
  subject { create :cmor_testimonials_category }

  context "associations" do
    it { should have_many :testimonials }
  end
end
