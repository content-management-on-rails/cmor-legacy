require "rails_helper"

module Cmor::Restaurant
  RSpec.describe Category, type: :model do
    describe "associations" do
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_presence_of(:name) }

      it { expect(subject).to validate_uniqueness_of(:identifier).scoped_to(:locale) }
      it { expect(subject).to validate_uniqueness_of(:name).scoped_to(:locale) }

      it { expect(subject).to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
    end
  end
end
