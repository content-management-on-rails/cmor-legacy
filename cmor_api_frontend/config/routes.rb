Cmor::Api::Backend::Engine.routes.draw do
  post "/graphql", to: "graphql#execute"
end