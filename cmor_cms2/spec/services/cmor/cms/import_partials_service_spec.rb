require 'rails_helper'

module Cmor::Cms
  describe ImportPartialsService do
    it { expect { ImportPartialsService.call }.to change { Cmor::Cms::Partial.count }.from(0).to(1) }

    describe 'the new partial' do
      before(:each) { ImportPartialsService.call }
      subject { Cmor::Cms::Partial.first }

      it { expect(subject.pathname).to eq('/import_partials_test/') }
      it { expect(subject.basename).to eq('_top_level') }
      it { expect(subject.locale).to eq('en') }
      it { expect(subject.format).to eq('html') }
      it { expect(subject.handler).to eq('erb') }
      it { expect(subject.body).to eq('<h1>Find me in app/views/import_partials_test/_top_level.html</h1>') }
    end
  end
end
