module Cmor
  module Cms
    class PageController < Cmor::Cms::Configuration.base_controller.constantize
      include Cmor::Cms::ControllerExtensions::PageResolver
      include Cmor::Cms::ControllerExtensions::PartialResolver

      def respond
        respond_to do |format|
          format.html { render template: params[:page] }
          format.json do
            render json: { content: render_to_string(template: params[:page], layout: false, formats: [:html]) }.to_json
          end
          format.txt  { render template: params[:page], layout: false, formats: [:text] }
        end
      end

      module MissingTemplateConcern
        extend ActiveSupport::Concern

        included do
          rescue_from ActionView::MissingTemplate do |exception|
            if exception.message.start_with?('Missing partial')
              handle_missing_partial(exception)
            else
              handle_missing_template(exception)
            end
          end
        end

        private

        def handle_missing_partial(exception)
          raise exception
        end

        def handle_missing_template(exception)
          if params[:page] == 'home'
            render_fallback_page
          else
            respond_to do |format|
              format.html { binding.pry; raise ActionController::RoutingError.new("No page matches [GET] \"/#{params[:page]}\"") }
              format.xml  { head :not_found }
              format.json { head :not_found }
              format.any  { head :not_found }
            end
          end
        end


        def render_fallback_page
          respond_to do |format|
            format.html { render :fallback }
            format.json { render json: { content: render_to_string(:fallback, layout: false, formats: [:html]) }.to_json }
            format.txt  { render :fallback }
          end
        end
      end

      include MissingTemplateConcern
    end
  end
end
