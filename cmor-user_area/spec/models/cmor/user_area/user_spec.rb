require "rails_helper"

RSpec.describe Cmor::UserArea::User do
  describe "class" do
    subject { described_class }

    describe "2fa" do
      it { expect(subject).to respond_to(:otp_random_secret) }
    end
  end

  it { expect(subject).to respond_to(:human) }

  describe "2fa" do
    it { expect(subject).to respond_to(:tfa_state) }
    it { expect(subject).to respond_to(:has_tfa?) }
  end

  describe "prepare_tfa" do
    it { expect { subject.prepare_tfa }.to change { subject.otp_backup_codes.size }.from(0).to(12) }
    it { expect { subject.prepare_tfa }.to change { subject.otp_secret_key.class }.from(NilClass).to(String) }
  end

  describe "disable_tfa" do
    before(:each) {
      subject.prepare_tfa
      subject.enable_tfa
    }

    it { expect { subject.disable_tfa }.to change { subject.otp_backup_codes.size }.from(12).to(0) }
    it { expect { subject.disable_tfa }.to change { subject.otp_secret_key.class }.from(String).to(NilClass) }
  end
end
