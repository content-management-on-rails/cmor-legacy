require "rails_helper"

RSpec.describe "/de/backend/blog", type: :feature do
  let(:base_path) { "/de/backend/blog" }

  before(:each) { visit(base_path) }

  it { expect(page.status_code).to eq(200) }
  it { expect(current_path).to eq(base_path) }
end
