module Cmor::UserArea
  class HomeControllerPolicy < (Cmor::Core.features?(:rbac) ? Cmor::Rbac::HomeControllerPolicy::Base : Object)
  end
end
