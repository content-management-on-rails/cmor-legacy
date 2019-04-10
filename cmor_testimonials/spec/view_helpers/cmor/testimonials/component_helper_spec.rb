require 'rails_helper'
require 'pry'

class DummyController < ApplicationController
  helper Cmor::Testimonials::ComponentHelper
end

RSpec.describe DummyControllerdo
  let(:test_controller) {DummyController.new}

  subject { test_controller.view_context }

  it { should respond_to(:render_component)}
  it { should respond_to(:render_testimonials) }
end