# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  include ActiveJob::TestHelper

  let(:post) { build(:post) }

  context "when saved as new record" do
    it { expect { post.save! }.to have_enqueued_job(Rao::Service::Job) }
    it { expect { perform_enqueued_jobs { post.save! } }.to change { Cmor::Seo::Item.count }.from(0).to(1) }
    it { expect { perform_enqueued_jobs { post.save! } }.to change { Cmor::Seo::MetaTag.count }.from(0).to(3) }
  end
end
