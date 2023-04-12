module Cmor::UserArea
  class UserPolicy < (Cmor::Core.features?(:rbac) ? Cmor::Rbac::ResourcesPolicy::Base : Object)
  end
end
