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

      module TwoFactorAuthenticationConcern
        extend ActiveSupport::Concern

        included do
          has_one_time_password Cmor::UserArea::Configuration.one_time_password_options
          #  rails 7.2 has changesd the method signature.
          if Rails.version >= "7.2"
            serialize :otp_backup_codes, type: Array, coder: YAML
          else
            serialize :otp_backup_codes, Array
          end

          include AASM

          aasm(:tfa_state, column: "tfa_state") do
            state :disabled, initial: true
            state :in_preparation
            state :enabled

            after_all_transitions :log_status_change

            event :prepare_tfa, before: :do_prepare_tfa do
              transitions from: [:disabled, :in_preparation], to: :in_preparation
            end

            event :enable_tfa do
              transitions from: :in_preparation, to: :enabled
            end

            event :disable_tfa, before: :do_disable_tfa do
              transitions from: [:in_preparation, :enabled], to: :disabled
            end
          end
        end

        def has_tfa?
          self.tfa_state == "enabled"
        end

        private

        def log_status_change
          puts "changing from #{aasm(:tfa_state).from_state} to #{aasm(:tfa_state).to_state} (event: #{aasm(:tfa_state).current_event})"
        end

        def do_prepare_tfa
          otp_regenerate_secret if !otp_column
          otp_regenerate_backup_codes if self.otp_backup_codes.empty?
        end

        def do_disable_tfa
          self.otp_secret_key = nil
          self.otp_backup_codes = []
        end
      end

      include TwoFactorAuthenticationConcern

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