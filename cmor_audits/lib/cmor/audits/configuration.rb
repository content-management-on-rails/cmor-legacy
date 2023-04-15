# frozen_string_literal: true

module Cmor::Audits
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :resources_controllers do
      -> { [] }
    end

    mattr_accessor :resource_controllers do
      -> { [] }
    end

    mattr_accessor :service_controllers do
      -> { [] }
    end

    mattr_accessor :sidebar_controllers do
      -> { [] }
    end

    mattr_accessor :audited_factory_name do
      :cmor_blog_post
    end

    mattr_accessor :resources do
      -> { {} }
    end

    mattr_accessor :whodunnit_class_name do
      'User'
    end

    mattr_accessor :whodunnit_find_proc do
      ->(whodunnit) { Cmor::Audits::Configuration.whodunnit_class_name.constantize.find_by(id: whodunnit) }
    end
  end
end
