require 'rails_helper'

module Cmor
  module Cms
    describe Folder do
      subject { FactoryBot.create :cmor_cms_folder }

      context 'associations' do
        it { should have_many :cmor_cms_pages }
        it { should have_many :cmor_cms_partials }
        it { should have_many :cmor_cms_templates }
      end

      context 'validations' do
        it { should validate_presence_of :pathname }
        it { should validate_presence_of :basename }
      end
    end
  end
end
