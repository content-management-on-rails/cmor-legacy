require 'rails_helper'

RSpec.describe 'Contact Widget', type: :system do
  describe 'basic usage' do
    let(:title) { "Kontaktanfrage stellen" }
    let(:submit_button) { within("form#new_contact_request") { find("input[type='submit']") } }
    before(:each) do
      visit("/")
      find("a[title='#{title}']").click
      within("form#new_contact_request") do
        fill_in "contact_request[name]", with: "Jane Doe"
        fill_in "contact_request[email]", with: "jane.doe@example.com"
        fill_in "contact_request[phone]", with: "+ 49 123 456789"
        fill_in "contact_request[message]", with: "This is a only a test!"
        check "contact_request[accept_terms_of_service]"
      end
    end

    describe 'UI changes' do
      let(:success_message) { "Ihre Kontaktanfrage wurde versandt." }
      
      before(:each) { submit_button.click }
      
      it { expect(page).to have_text(success_message) }
    end

    describe 'persistence changes' do
      it { expect{ submit_button.click; find(".alert.alert-success"); }.to change{ Cmor::Contact::ContactRequest.count }.from(0).to(1) }
    end
  end
end
