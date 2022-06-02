# frozen_string_literal: true

module Cmor::Seo::Frontend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { "::FrontendController" }
    mattr_accessor(:title_tag_fallback) { -> { "<title>#{Rails.application.class.name.deconstantize.titleize}</title>".html_safe } }
  end
end
