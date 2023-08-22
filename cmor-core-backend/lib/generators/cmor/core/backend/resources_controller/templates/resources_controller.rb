module <%= controller_class.deconstantize %>
  class <%= controller_class.demodulize %> < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      <%= resource_class %>
    end

    private

    def permitted_params
      params.require(:<%= params_name %>).permit()
    end
  end
end