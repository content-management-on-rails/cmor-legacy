require "rails_helper"

RSpec.describe "/de/backend/restaurant", type: :feature do
  let(:base_url) { "/de/backend/restaurant" }

  describe "home" do
    before(:each) do
      visit base_url
    end

    it { expect(page.status_code).to eq(200) }
  end
end
