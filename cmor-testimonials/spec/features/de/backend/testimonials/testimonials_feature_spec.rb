require "rails_helper"

RSpec.describe "/de/backend/testimonials/testimonials", type: :feature do
  let(:category) { create(:cmor_testimonials_category) }

  let(:resource_class) { Cmor::Testimonials::Testimonial }
  let(:resource) { create(:cmor_testimonials_testimonial) }
  let(:resources) { create_list(:cmor_testimonials_testimonial, 3) }

  it { expect(subject).to implement_index_action(self) }
  it { expect(subject).to implement_show_action(self).for(resource) }

  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_testimonial") {
        fill_in "testimonial[body]", with: "New body"
      }
      .updating
      .from(resource.attributes)
      .to({"body" => "New body"})
  }

  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }

  describe "appending image on create" do
    it {
      category
      expect(subject).to implement_create_action(self)
        .for(Cmor::Testimonials::Testimonial)
        .within_form("#new_testimonial") {
          select category.human, from: "testimonial[category_id]"
          fill_in "testimonial[fullname]", with: "John Doe"
          attach_file "testimonial[image]", Cmor::Testimonials::Engine.root.join(*%w[spec files cmor testimonials testimonials homer.png])
        }
        .increasing { Cmor::Testimonials::Testimonial.count }.by(1)
    }
  end

  describe "replacing image on update" do
    let(:resource) { create(:cmor_testimonials_testimonial) }
    let(:base_path) { "/de/backend/testimonials/testimonials" }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }
    let(:filename) { "enerbunny.png" }

    let(:submit_button) { within("form.edit_testimonial") { first('input[type="submit"]') } }

    before(:each) do
      visit(edit_path)
      attach_file "testimonial[image]", Cmor::Testimonials::Engine.root.join(*%W[spec files cmor testimonials testimonials #{filename}])
      submit_button.click
      resource.reload
    end

    it { expect(resource.image.filename.to_s).to eq(filename) }
  end
end
