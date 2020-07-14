require 'rails_helper'

RSpec.describe Cmor::Blog::Post, type: :model do
  let(:resource) { create(:cmor_blog_post) }

  before(:each) { resource.update_attribute(:title, 'New title') }

  it { expect(resource.versions.size).to eq(2) }
end
