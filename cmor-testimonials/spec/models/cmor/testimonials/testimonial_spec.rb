require "rails_helper"

RSpec.describe Cmor::Testimonials::Testimonial, type: :model do
  subject { create :cmor_testimonials_testimonial }

  context "acts as list" do
    it { should respond_to(:move_to_top) }
    it { should respond_to(:move_higher) }
    it { should respond_to(:move_lower) }
    it { should respond_to(:move_to_bottom) }
  end

  context "associations" do
    it { should belong_to :category }
  end

  context "active_storage" do
    it { should respond_to :image }
  end

  describe "attach image" do
    let(:filename) { "homer.png" }
    let(:file) { File.open(Cmor::Testimonials::Engine.root.join(*%W[spec files cmor testimonials testimonials #{filename}])) }

    before(:each) do
      subject.image.attach(io: file, filename: filename, content_type: "image/png")
      subject.save!
    end

    it { expect(subject.image).to be_attached }
    it { expect(subject.image.filename.to_s).to eq(filename) }
  end
end
