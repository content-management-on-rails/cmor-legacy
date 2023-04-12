module Cmor::UserArea
  class EnginePolicy < (Cmor::Core.features?(:rbac) ? Cmor::Rbac::EnginePolicy::Base : Object)
  end
end
