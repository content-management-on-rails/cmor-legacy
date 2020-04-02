module Cmor::MultiTenancy
  class Client < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }, length: { minimum: 3, maximum: 63 }
    validates :title, presence: true, uniqueness: true

    def human
      title
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

    include ActiveConcern

    module DefaultConcern
      extend ActiveSupport::Concern

      included do
        validates :default, uniqueness: true, if: :default

        scope :default, -> { where.not(default: nil) }
      end
    end

    include DefaultConcern
  end
end
