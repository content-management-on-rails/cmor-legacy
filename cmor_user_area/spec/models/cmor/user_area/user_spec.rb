require 'rails_helper'

RSpec.describe Cmor::UserArea::User do
  it { expect(subject).to respond_to(:human) }
  it { expect(subject).to respond_to(:tfa_state) }
end
