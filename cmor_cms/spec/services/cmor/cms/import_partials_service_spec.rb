require 'rails_helper'

RSpec.describe Cmor::Cms::ImportPartialsService, type: :model do
  let(:partial_path) { Rails.root.join(*%w(app views _example_partial.en.html.erb)) }
  let(:partial_content) { "<h1>Find me in app/views/_example_partial.en.html.erb</h1>" }

  before(:each) { File.write(partial_path, partial_content) }
  after(:each) { File.delete(partial_path) }

  describe 'basic usage' do
    subject { described_class.call }

    it { expect(subject).to be_ok }
    it { expect(subject.errors.full_messages).to eq([]) }
  end

  describe 'changes' do
    it { expect { described_class.call }.to change { Cmor::Cms::Partial.count }.from(0).to(1) }
  end

  describe 'the new partial' do
    before(:each) { described_class.call }

    subject { Cmor::Cms::Partial.first }

    it { expect(subject.pathname).to eq('/') }
    it { expect(subject.basename).to eq('_example_partial') }
    it { expect(subject.locale).to eq('en') }
    it { expect(subject.format).to eq('html') }
    it { expect(subject.handler).to eq('erb') }
    it { expect(subject.body).to eq(partial_content) }
  end
end