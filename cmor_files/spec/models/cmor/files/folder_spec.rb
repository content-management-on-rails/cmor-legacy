require 'rails_helper'

module Cmor::Files
  RSpec.describe Folder, type: :model do
    it { expect(subject).to respond_to(:assets=) }
    it { expect(subject).to respond_to(:assets) }
    it { expect(subject).to respond_to(:assets_count) }
    
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_uniqueness_of(:name) }
  end
end
