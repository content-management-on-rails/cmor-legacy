module Delayed
  module Backend
    module ActiveRecord
      class JobPolicy < Cmor::Rbac::ResourcesPolicy::Base
      end
    end
  end
end
