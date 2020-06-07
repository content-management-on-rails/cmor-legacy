module Cmor::Transports
  # First you have to add the helper and the export concern to your controller:
  #
  #     # app/controllers/application_controller.rb
  #     class ApplicationController < ActionController::Base
  #       include Cmor::Transports::ResourcesController::ExportConcern
  #       view_helper Cmor::Transports::ExportViewHelper, as: :export_helper
  #       # ....
  #     end
  #
  class ExportViewHelper < Rao::ViewHelper::Base
    # Example:
    #
    #     # app/views/posts/index.html.haml
    #     = export_helper(self).form_for(@posts, url: posts_path, method: :get) do |f|
    #       = f.input :email_cont, association: :author
    #       = f.input :title_cont
    #       = f.input :body_cont
    #       = f.boolean :published_eq
    #       = f.submit nil, class: 'btn btn-primary'
    #       = f.reset  nil, class: 'btn btn-default'
    #
    #     # app/controllers/posts_controller.rb
    #     class ApplicationController < ActionController::Base
    #       def index
    #         @posts = with_conditions_from_query(Post).all
    #       end
    #
    # If you are using bootstrap you may want to display the form inline for a
    # more compact view:
    #
    #     = query_helper(self).form_for(collection, html: { class: 'form-inline' }) do |f|
    #
    def form_for(collection, options = {}, &block)
      handle_simple_form_missing unless c.respond_to?(:simple_form_for)
      wrapped_collection = ExportableCollection.new(collection)
      c.simple_form_for(wrapped_collection, options.reverse_merge(as: :q, url: { action: :export }), &block)
    end

    class ExportableCollection
      include ActiveModel::Model
      extend ActiveModel::Translation

      def initialize(collection)
        @collection = collection
      end

      def original_model_class_name
        @collection.class.to_s.deconstantize
      end

      def original_model_class
        @collection.klass
      end
    end

    def handle_simple_form_missing
      raise "simple_form_for is not available. Please add simple_form to your Gemfile."
    end
  end
end