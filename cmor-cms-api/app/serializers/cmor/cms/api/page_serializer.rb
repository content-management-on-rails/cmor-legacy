module Cmor::Cms::Api
  class PageSerializer
    def initialize(resource, params = {})
      @resource = resource
      @params = params
    end

    def as_json
      @resource.as_json.merge(
        html: html
      )
    end

    def html
      return unless [ 'html', '', nil ].include?(@resource.format)
      rendered = ApplicationController.render(
        inline: @resource.body,
      )
      if @resource.handler == 'textile'
        RedCloth.new(rendered).to_html
      else
        rendered
      end
    end
  end
end
