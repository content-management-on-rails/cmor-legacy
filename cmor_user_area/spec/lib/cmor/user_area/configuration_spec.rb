require 'rails_helper'

RSpec.describe Cmor::UserArea::Configuration do
  subject { described_class }

  it { expect(subject).to respond_to(:enable_registrations) }
  it { expect(subject).to respond_to(:allow_users_to_destroy_self) }
  it { expect(subject).to respond_to(:base_controller) }
  it { expect(subject).to respond_to(:base_mailer) }
  it { expect(subject).to respond_to(:acts_as_authentic_options) }
  it { expect(subject).to respond_to(:application_name) }
  it { expect(subject).to respond_to(:email_from_address) }
  it { expect(subject).to respond_to(:current_user_additional_table_rows_proc) }
  it { expect(subject).to respond_to(:after_sign_in_url) }
  it { expect(subject).to respond_to(:after_sign_out_url) }
  it { expect(subject).to respond_to(:enable_tfa) }
end