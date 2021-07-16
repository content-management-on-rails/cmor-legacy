require 'rails_helper'

RSpec.describe Cmor::Security::AntivirusConfiguration, type: :model do
  describe 'instance' do
    subject { described_class.new }

    it { expect(subject).to respond_to(:model_class) }
    it { expect(subject).to respond_to(:model_class_name) }
    it { expect(subject).to respond_to(:attachment_name) }
    it { expect(subject).to respond_to(:options) }
  end
end
