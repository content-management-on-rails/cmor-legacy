require 'rails_helper'

module Cmor::Core::Settings
  RSpec.describe Setting, type: :model do
    describe "validations" do
      # it { expect(subject).to validate_presence_of(:namespace) }
      # it { expect(subject).to validate_presence_of(:key) }
      # it { expect(subject).to validate_uniqueness_of(:key).scoped_to(:namespace) }
    end

    describe "dynamic validations" do
      describe "presence" do
        let(:setting) { Setting.new(namespace: "Cmor::Contact", key: "contact_request.sender", validations: { presence: true }) }

        it { expect(setting).to validate_presence_of(:value) }
      end

      describe "format" do
        let(:setting) { Setting.new(namespace: "Cmor::Contact", key: "contact_request.sender", validations: { format: { with: /.*@.*/ } }) }

        # it { expect(setting).not_to allow_value("foo").for(:value) }
      end
    end
  end
end
