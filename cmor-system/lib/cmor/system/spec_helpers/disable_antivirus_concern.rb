module Cmor
  module System
    module SpecHelpers
      module DisableAntivirusConcern
        extend ActiveSupport::Concern

        included do
          before(:each) do
            allow_any_instance_of(TatoruValidator::MalwareScan).to receive(:result).and_return("status" => "clean")
          end
        end
      end
    end
  end
end
