require "cmor_core_frontend"

require "<%= name.underscore %>/configuration"
require "<%= name.underscore %>/engine"

<%= nested_modules(content: "extend Configuration\n") %>