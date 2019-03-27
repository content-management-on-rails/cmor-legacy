require 'rails_helper'

RSpec.describe '/de/blog/posts', type: :feature do
  let(:resource_class) { Cmor::Blog::Post }
  let(:resource) { create(:cmor_blog_post, published_at: 5.minutes.ago) }
  let(:resources) { create_list(:cmor_blog_post, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }
end
