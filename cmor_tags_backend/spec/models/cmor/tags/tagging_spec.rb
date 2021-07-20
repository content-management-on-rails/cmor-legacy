require 'rails_helper'

RSpec.describe Cmor::Tags::Tagging, type: :model do
  describe '#taggable=' do
    let(:taggable) { create(Cmor::Tags::Configuration.taggable_factory_name) }

    describe 'using a gid' do
      let(:taggable_gid) { taggable.to_global_id }

      let(:subject) { described_class.new }

      it { subject.taggable = taggable_gid; expect(subject.taggable).to eq(taggable) }
    end
  end
  
  describe '#tagger=' do
    let(:tagger) { create(Cmor::Tags::Configuration.taggable_factory_name) }

    describe 'using a gid' do
      let(:tagger_gid) { tagger.to_global_id }

      let(:subject) { described_class.new }

      it { subject.tagger = tagger_gid; expect(subject.tagger).to eq(tagger) }
    end
  end
end
