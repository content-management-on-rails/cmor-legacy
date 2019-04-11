module <%= controller_class.deconstantize %>
  class <%= controller_class.demodulize %> < <%= current_engine.chomp('::Engine') %>::Configuration.base_controller.constantize
    include Rao::ResourceController::RestActionsConcern
    include Rao::ResourceController::ResourceConcern
    include Rao::Resourcesontroller::RestResourceUrlsConcern
    include Rao::ResourceController::ResourceInflectionsConcern

    def self.resource_class
      <%= resource_class %>
    end

    private

    def permitted_params
      params.require(:<%= params_name %>).permit()
    end
  end
end