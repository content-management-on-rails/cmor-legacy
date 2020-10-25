require 'rails_helper'

RSpec.describe Cmor::UserArea::User do
  describe 'class' do
    subject { described_class }

    describe "2fa" do
      it { expect(subject).to respond_to(:otp_random_secret) }
      it { expect(subject).to respond_to(:otp_backup_codes) }
    end
  end

  it { expect(subject).to respond_to(:human) }

  describe "2fa" do
    it { expect(subject).to respond_to(:tfa_state) }
    it { expect(subject).to respond_to(:has_tfa?) }
  end
end
