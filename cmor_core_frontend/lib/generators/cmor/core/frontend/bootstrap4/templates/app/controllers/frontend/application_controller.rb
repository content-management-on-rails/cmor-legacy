# frozen_string_literal: true

module Frontend
  class ApplicationController < ActionController::Base
    include Cmor::UserArea::Controller::RedirectBackConcern
    include Cmor::UserArea::Controller::CurrentUserConcern

    view_helper Cmor::Cms::ApplicationViewHelper, as: :cms_helper
    view_helper Cmor::Cms::PageViewHelper, as: :cms_page_helper
    view_helper Cmor::Cms::NavigationViewHelper, as: :cms_navigation_helper
    view_helper Cmor::Carousels::ApplicationViewHelper, as: :carousels_helper
    view_helper Cmor::Core::MarkupViewHelper, as: :markup_helper
    view_helper Twitter::Bootstrap::Components::Rails::V4::ViewHelper, as: :bootstrap_helper
    view_helper Frontend::ApplicationViewHelper, as: :frontend_helper
    view_helper Blueimp::Gallery::ApplicationViewHelper, as: :blueimp_gallery_helper
    view_helper EuGdpr::ApplicationViewHelper, as: :eu_gdpr_helper
    view_helper Cmor::UserArea::ApplicationViewHelper, as: :user_area_helper
    view_helper Cmor::Links::ApplicationViewHelper, as: :links_helper

    helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper
  end
end
