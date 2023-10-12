module Cmor
  module Core
    module SpecHelpers
      module Feature
        def sign_in(user)
          visit("/#{I18n.locale}/#{I18n.t("routes.cmor_user_area_engine")}/#{I18n.t("routes.user_session")}/new")
          fill_in "user_session[email]", with: user.email
          fill_in "user_session[password]", with: user.password
          click_button(I18n.t("helpers.submit.user_session.create"))
        end

        def select_date_and_time(date, options = {})
          field = options[:from]
          select I18n.l(date, format: "%Y"), from: "#{field}_1i" # year
          select I18n.l(date, format: "%B"), from: "#{field}_2i" # month
          select I18n.l(date, format: "%-d"), from: "#{field}_3i" # day
          select I18n.l(date, format: "%H"), from: "#{field}_4i" # hour
          select I18n.l(date, format: "%M"), from: "#{field}_5i" # minute
        end

        def select_date(date, options = {})
          field = options[:from]
          select I18n.l(date, format: "%Y"), from: "#{field}_1i" # year
          select I18n.l(date, format: "%B"), from: "#{field}_2i" # month
          select I18n.l(date, format: "%-d"), from: "#{field}_3i" # day
        end
      end
    end
  end
end
