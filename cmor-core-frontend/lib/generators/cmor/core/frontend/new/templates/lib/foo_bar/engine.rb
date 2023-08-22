module <%= name %>
  class Engine < ::Rails::Engine
    isolate_namespace <%= name %>
  end
end
