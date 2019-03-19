module Cmor
  module Tags
    class TagSearchsController < Cmor::Tags::Configuration.base_controller.constantize
      respond_to :html, :json

      def new
        @tag_search = TagSearch.new
        @result = {}
        respond_with @tag_search do |format|
          format.html
          format.json { render json: @tag_search }
        end
      end

      def create
        if request.get?
          @tag_search = TagSearch.new(tag_list: permitted_params)
        else
          @tag_search = TagSearch.new(permitted_params)
        end
        @result = @tag_search.result
        respond_with @tag_search do |format|
          format.html { render :new }
          format.json { render json: @tag_search }
        end
      end

      private

      def new_resource_path
        url_for(action: :new)
      end

      def permitted_params
        if request.get?
          params.require(:tag)
        else
          params.require(:tag_search).permit(:tag_list, :exact)
        end
      end
    end
  end
end
