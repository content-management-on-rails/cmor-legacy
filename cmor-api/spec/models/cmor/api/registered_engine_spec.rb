require "rails_helper"

module Cmor::Api
  RSpec.describe RegisteredEngine, type: :model do
    it { expect(subject).to respond_to(:options) }
    it { expect(subject).to respond_to(:class_name) }
    it { expect(subject).to respond_to(:name) }
    it { expect(subject).to respond_to(:resources) }
  end
end
