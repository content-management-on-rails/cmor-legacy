module Cmor::UserArea
  class UserMailer < Cmor::UserArea::Configuration.base_mailer.constantize
    default from: Configuration.email_from_address.call

    def password_reset_email(user, host, application_name = nil)
      @host = host
      @user = user
      @application_name = application_name || Configuration.application_name
      mail(to: @user.email)
    end
  end
end