require 'rails_helper'

RSpec.describe Cmor::Testimonials::ViewComponent, type: :model do
  it { should respond_to :render }
  it { should respond_to :context }  
end
