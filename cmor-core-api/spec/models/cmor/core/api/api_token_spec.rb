require 'rails_helper'

module Cmor::Core::Api
  RSpec.describe ApiToken, type: :model do
    describe "validations" do
      it { expect(subject).to validate_presence_of(:description) }
      it { expect(subject).to validate_uniqueness_of(:description) }
    end

    describe 'token' do
      it { expect(subject).to respond_to(:token) }
      it { expect(subject.token).to be_present }
    end
  end
end
