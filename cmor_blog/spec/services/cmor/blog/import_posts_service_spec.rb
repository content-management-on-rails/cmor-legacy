require 'rails_helper'

RSpec.describe Cmor::Blog::ImportPostsService, type: :model do
  it { expect(described_class.call).to be_a(Rao::Service::Result::Base) }
end