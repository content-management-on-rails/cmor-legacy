module Cmor::Rbac
  class UserRole < ActiveRecord::Base
    # associations
    belongs_to :user, class_name: Cmor::Rbac::Configuration.user_class_name, foreign_key: 'user_id', inverse_of: :user_roles
    belongs_to :role, inverse_of: :user_roles

    if Rails.version >= '5.0.0'
      belongs_to :enabled_role, -> { enabled }, foreign_key: 'role_id', class_name: 'Cmor::Rbac::Role', optional: true
    else
      belongs_to :enabled_role, -> { enabled }, foreign_key: 'role_id', class_name: 'Cmor::Rbac::Role'
    end
    has_many :enabled_role_permissions, through: :enabled_role, source: :user_roles, class_name: 'Cmor::Rbac::RolePermission'
    has_many :enabled_permissions, through: :enabled_role_permissions, class_name: 'Cmor::Rbac::Permission', source: :permission

    # validations
    validates :user, presence: true
    validates :user_id, uniqueness: { scope: :role_id }
    validates :role, presence: true
  end
end
