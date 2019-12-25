require 'rails_helper'

RSpec.describe '/de/kontakt/whatsapp', type: :feature do
  around(:each) do |example|
    whatsapp_number = "+49 123 4567890"
    @_cmor_contact_whatsapp_number = Cmor::Contact::Configuration.whatsapp_number
    Cmor::Contact::Configuration.whatsapp_number = whatsapp_number
    example.run
    Cmor::Contact::Configuration.whatsapp_number = @_cmor_contact_whatsapp_number
  end

  let(:resource_class) { Cmor::Contact::WhatsappRequest }
  let(:resource) { create(:cmor_whatsapp_request) }

  let(:base_path) { "/de/kontakt/whatsapp" }

  describe 'index/create' do
    let(:submit_button) { find("input[type='submit']") }

    before(:each) do
      visit(base_path)
    end

    describe 'success' do
      let(:after_success_path) { "/de/kontakt" }

      before(:each) do
        within('#new_whatsapp_request') do
          fill_in "whatsapp_request[message]", with: "This is the message!"
        end
      end

      it { expect(page.status_code).to eq(200) }
      it { expect(current_path).to eq(base_path) }
      it do
        pending "This can't be tested in a feature spec."
        submit_button.click; expect(current_path).to eq(after_success_path)
      end
    end
  end
end
