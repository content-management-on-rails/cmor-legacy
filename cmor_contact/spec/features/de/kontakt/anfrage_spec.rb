require 'rails_helper'

RSpec.describe '/de/kontakt/anfrage', type: :feature do
  let(:resource_class) { Cmor::Contact::ContactRequest }
  let(:resource) { create(:cmor_contact_request) }

  let(:base_path) { "/de/kontakt/anfrage" }

  describe 'index/create' do
    let(:submit_button) { find("input[type='submit']") }

    before(:each) do
      visit(base_path)
    end

    describe 'success' do
      let(:after_success_path) { "/de/kontakt" }

      before(:each) do
        within('#new_contact_request') do
          fill_in "contact_request[name]", with: "Jane Doe"
          fill_in "contact_request[email]", with: "jane.doe@domain.local"
          fill_in "contact_request[phone]", with: "+49 123 4567890"
          fill_in "contact_request[message]", with: "This is the message!"
          check "contact_request[accept_terms_of_service]"
        end
      end

      it { expect(page.status_code).to eq(200) }
      it { expect(current_path).to eq(base_path) }
      it { expect{ submit_button.click }.to change{ resource_class.count }.by(1) }
      it { submit_button.click; expect(current_path).to eq(after_success_path) }
    end
  end
end
