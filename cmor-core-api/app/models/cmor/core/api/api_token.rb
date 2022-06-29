module Cmor::Core::Api
  class ApiToken < ApplicationRecord
    module TokenConcern
      extend ActiveSupport::Concern

      included do
        if Rails.version >= "7.0"
          encrypts :token, deterministic: true
        else
          puts "[Cmor::Core::Api] Warning: Could not enable api token encryption. Please update to rails >= 7.0 to enable encryption."
        end

        after_initialize :initialize_token, if: :new_record?
      end

      private

      def initialize_token
        self.token ||= SecureRandom.hex(32)
      end
    end

    module ActiveConcern
      extend ActiveSupport::Concern

      included do
        validates :active_from, presence: true
        validates :active_to, presence: true

        scope :active, -> { active_at(Time.zone.now) }
        scope :active_at, ->(point_in_time) {
          t = arel_table
          where(t[:active_from].lteq(point_in_time)).where(t[:active_to].gteq(point_in_time))
        }

        after_initialize do
          self.active_from ||= Time.at(0)
          self.active_to   ||= Time.new(9999, 12, 31, 23, 59, 59)
        end
      end
    end

    module AuthenticationConcern
      extend ActiveSupport::Concern

      class_methods do
        def authenticate(token, options)
          active.where(token: token).first
        end
      end
    end

    include ActiveConcern
    include TokenConcern
    include AuthenticationConcern
  end
end
