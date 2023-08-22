module <%= controller_class.deconstantize %>
  class <%= controller_class.demodulize %> < <%= current_engine.chomp('::Engine') %>::Configuration.base_controller.constantize
    include Rao::ResourcesController::RestActionsConcern
    include Rao::ResourcesController::ResourcesConcern
    include Rao::ResourcesController::RestResourceUrlsConcern
    include Rao::ResourcesController::ResourceInflectionsConcern

    def self.resource_class
      <%= resource_class %>
    end

    private

    def permitted_params
      params.require(:<%= params_name %>).permit()
    end
  end
end