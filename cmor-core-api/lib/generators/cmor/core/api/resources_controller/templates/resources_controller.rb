class <%= controller_class %> < <%= controller_parent_class %>
  include Rao::Api::ResourcesController::RestActionsConcern
  include Rao::Api::ResourcesController::ResourcesConcern
  include Rao::Api::ResourcesController::CountActionConcern
  include Rao::Api::ResourcesController::DestroyAllActionConcern
  include Rao::Api::ResourcesController::DeleteAllActionConcern
  include Rao::Api::ResourcesController::FirstActionConcern
  include Rao::Api::ResourcesController::LastActionConcern
  include Rao::Api::ResourcesController::ExceptionHandlingConcern
  include Cmor::Core::Api::ResourcesController::SerializationConcern
  include Rao::Query::Controller::QueryConcern

  def self.resource_class
    <%= resource_class %>
  end

  private

  def permitted_params
    params.require(:<%= params_name %>).permit()
  end
end
