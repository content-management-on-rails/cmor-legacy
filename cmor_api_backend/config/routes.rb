Cmor::Api::Frontend::Engine.routes.draw do
  post "/graphql", to: "graphql#execute"
end