module Cmor::UserArea
  class CreateDefaultUserServicePolicy < (Cmor::Core.features?(:rbac) ? Cmor::Rbac::ServicePolicy::Base : Object)
  end
end
