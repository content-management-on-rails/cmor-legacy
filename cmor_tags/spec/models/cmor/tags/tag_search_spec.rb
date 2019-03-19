require 'rails_helper'

module Cmor::Tags
  describe TagSearch do
    context 'instance' do
      subject { Cmor::Tags::TagSearch.new }

      it { expect(subject).to be_a(Cmor::Tags::TagSearch) }
    end

    context 'simple search' do
      subject do
        @post = create(:post)
        @post.tag_list.add('foo')
        @post.save!
        Cmor::Tags::TagSearch.new(tag_list: 'foo').do_work
      end

      it 'should return a hash' do
        expect(subject).to be_a(Hash)
      end

      it { expect(subject.keys).to include('Post') }
      it { expect(subject['Post'].size).to eq(1) }
    end

    context 'fuzzy search' do
      subject do
        @post = create(:post)
        @post.tag_list.add('foo')
        @post.save!
        Cmor::Tags::TagSearch.new(tag_list: 'f', fuzzy: true).do_work
      end

      it 'should return a hash' do
        expect(subject).to be_a(Hash)
      end

      it { expect(subject.keys).to include('Post') }
      it { expect(subject['Post'].size).to eq(1) }
    end
  end
end
