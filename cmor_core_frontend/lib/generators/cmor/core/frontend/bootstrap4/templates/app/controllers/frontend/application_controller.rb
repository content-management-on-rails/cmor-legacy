# frozen_string_literal: true

module Frontend
  class ApplicationController < ActionController::Base
    include Cmor::UserArea::Controller::RedirectBackConcern
    include Cmor::UserArea::Controller::CurrentUserConcern

    view_helper Frontend::ApplicationViewHelper, as: :frontend_helper

    view_helper Cmor::Cms::ApplicationViewHelper, as: :cms_helper
    view_helper Cmor::Cms::PageViewHelper, as: :cms_page_helper
    view_helper Cmor::Cms::NavigationViewHelper, as: :cms_navigation_helper
    view_helper Cmor::UserArea::ApplicationViewHelper, as: :user_area_helper
    view_helper Cmor::Links::ApplicationViewHelper, as: :links_helper

    view_helper Blueimp::Gallery::ApplicationViewHelper, as: :blueimp_gallery_helper
    view_helper EuGdpr::ApplicationViewHelper, as: :eu_gdpr_helper
    view_helper Markup::Rails::ApplicationViewHelper, as: :markup_helper
  end
end
