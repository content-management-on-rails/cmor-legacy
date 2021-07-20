require 'rails_helper'

RSpec.describe '/de/backend/sicherheit', type: :feature do
  let(:base_path) { '/de/backend/sicherheit' }

  before(:each) do
    visit(base_path)
  end

  it { expect(current_path).to eq(base_path) }
  it { expect(page.body).to have_text("Home") }
end
