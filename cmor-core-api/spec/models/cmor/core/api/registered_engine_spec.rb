require "rails_helper"

module Cmor::Core::Api
  RSpec.describe RegisteredEngine, type: :model do
    it { expect(subject).to respond_to(:class_name) }
    it { expect(subject).to respond_to(:name) }
    it { expect(subject).to respond_to(:options) }
    it { expect(subject).to respond_to(:plural_resource) }
    it { expect(subject).to respond_to(:services) }
    it { expect(subject).to respond_to(:sidebars) }
    it { expect(subject).to respond_to(:singular_resources) }
  end
end
