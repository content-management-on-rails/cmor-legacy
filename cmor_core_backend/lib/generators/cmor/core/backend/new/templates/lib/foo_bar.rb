require "<%= name.underscore %>/configuration"
require "<%= name.underscore %>/engine"

<%= nested_modules(content: "extend Configuration\n") %>