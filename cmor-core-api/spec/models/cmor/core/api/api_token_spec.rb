require 'rails_helper'

module Cmor::Core::Api
  RSpec.describe ApiToken, type: :model do
    it { expect(subject).to respond_to(:token) }

    describe 'token' do
      it { expect(subject.token).to be_present }
    end
  end
end
