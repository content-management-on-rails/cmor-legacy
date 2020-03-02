# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Legal::Frontend::ApplicationViewHelper, type: :view_helper do
  it { expect(subject).to respond_to(:render_cookie_consent_banner) }
  it { expect(subject).to respond_to(:cookie_preferences_pending?) }
  it { expect(subject).to respond_to(:cookie_preferences) }
  it { expect(subject).to respond_to(:render_cookie_preferences) }
end
