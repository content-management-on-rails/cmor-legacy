module <%= controller_class.deconstantize %>
  class <%= controller_class.demodulize %> < Cmor::Core::Backend::ServiceController::Base
    def self.service_class
      <%= service_class %>
    end

    private

    def permitted_params
      params.require(:<%= params_name %>).permit()
    end
  end
end