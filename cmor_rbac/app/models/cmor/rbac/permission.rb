module Cmor::Rbac
  class Permission < ActiveRecord::Base
    include Model::FlagFromTimeRangeConcern

    DEFAULTS = {
      enabled_from: '01.01.1900 00:00:00',
      enabled_to:   '31.12.9999 23:59:59'
    }

    # associations
    has_many :role_permissions, class_name: 'Cmor::Rbac::RolePermission', dependent: :destroy
    has_many :roles, class_name: 'Cmor::Rbac::Role', through: :role_permissions
    has_many :user_roles, through: :roles, class_name: 'Cmor::Rbac::UserRole'
    has_many :users, through: :user_roles, class_name: Cmor::Rbac::Configuration.user_class_name

    has_many :enabled_roles, -> { enabled }, class_name: 'Cmor::Rbac::Role', through: :role_permissions, source: :permission
    has_many :enabled_user_roles, class_name: 'Cmor::Rbac::UserRole', through: :enabled_roles, source: :role_permissions

    has_many :enabled_users, through: :enabled_user_roles, class_name: Cmor::Rbac::Configuration.user_class_name, source: :user

    flag_from_time_range :enabled?

    # scopes
    scope :glob, ->(exp, column: :identifier) { where(["#{column} LIKE ?",  exp.gsub("*", "%")]) }

    # validations
    validates :identifier, presence: true, uniqueness: true
    validates :enabled_from, presence: true
    validates :enabled_to, presence: true

    # callbacks
    after_initialize :set_defaults

    def human
      "#{self.class.model_name.human}: #{identifier}"
    end

    private

    def set_defaults
      return if persisted?
      self.enabled_from = DEFAULTS[:enabled_from]
      self.enabled_to = DEFAULTS[:enabled_to]
    end
  end
end
