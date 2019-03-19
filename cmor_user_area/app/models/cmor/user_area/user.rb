require 'bcrypt'

module Cmor
  module UserArea
    class User < ActiveRecord::Base
      acts_as_authentic &Cmor::UserArea::Configuration.acts_as_authentic_options

      scope :autocomplete,  ->(matcher) { where("LOWER(email) LIKE ?", "%#{matcher.downcase}%") }
      scope :authenticable, -> { where(active: true, confirmed: true, approved: true) }

      def as_json(options = {})
        options.reverse_merge!(style: :default)

        style = options.delete(:style)

        case style
        when :autocomplete
          { value: id, title: human, subtitle: self.inspect }
        else
          super
        end
      end

      def authenticable?
        [active, confirmed, approved].all?
      end

      def human
        email
      end

      module ValidationConcern
        extend ActiveSupport::Concern

        included do
          # Validate email, login, and password as you see fit.
          #
          # Authlogic < 5 added these validation for you, making them a little awkward
          # to change. In 4.4.0, those automatic validations were deprecated. See
          # https://github.com/binarylogic/authlogic/blob/master/doc/use_normal_rails_validation.md
          validates :email,
            format: {
              with: /@/,
              message: "should look like an email address."
            },
            length: { maximum: 100 },
            uniqueness: {
              case_sensitive: false,
              if: :will_save_change_to_email?
            }

          # validates :login,
          #   format: {
          #     with: /\A[a-z0-9]+\z/,
          #     message: "should use only letters and numbers."
          #   },
          #   length: { within: 3..100 },
          #   uniqueness: {
          #     case_sensitive: false,
          #     if: :will_save_change_to_login?
          #   }

          validates :password,
            confirmation: { if: :require_password? },
            length: {
              minimum: 8,
              if: :require_password?
            }
          validates :password_confirmation,
            length: {
              minimum: 8,
              if: :require_password?
          }
        end
      end

      include ValidationConcern
    end
  end
end