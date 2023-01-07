require "rails_helper"

module Cmor::UserArea
  describe CreateDefaultUserService do
    it { expect(subject).to be_a(Rao::Service::Base) }

    it "should create a user" do
      expect do
        CreateDefaultUserService.call
      end.to change {
        Cmor::UserArea::User.count
      }.from(0).to(1)
    end

    describe "created user" do
      subject { CreateDefaultUserService.call.user }

      it { expect(subject.email).to eq("user@example.com") }
      it { expect(subject.active).to be_truthy }
      it { expect(subject.approved).to be_truthy }
      it { expect(subject.confirmed).to be_truthy }
    end

    describe "when user already exists" do
      before(:each) do
        create(:cmor_user_area_user, email: "user@example.com")
      end

      it "should not change the user count" do
        expect do
          CreateDefaultUserService.call
        end.to_not change(Cmor::UserArea::User, :count)
      end
    end
  end
end
