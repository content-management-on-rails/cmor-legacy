Cmor::Api::Backend::Engine.routes.draw do
  # post "/graphql", to: "graphql#execute"
  match "/graphql", to: "graphql#execute", via: [:post, :options]
end