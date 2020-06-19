require 'rails_helper'

RSpec.describe "/de/backend/cms/navigation_items/export", type: :feature do
  let(:base_path) { "/de/backend/cms/navigation_items/export" }

  describe 'basic usage' do
    before(:each) do
      visit(base_path)
      select "csv", from: 'export[output_format]' 
    end

    it { find("input[type='submit']").click; expect(current_path).to eq("/de/backend/transporte/exports/#{Cmor::Transports::Export.first.to_param}") }
    it { expect { find("input[type='submit']").click }.to change { Cmor::Transports::Export.count }.from(0).to(1) }
  end
end