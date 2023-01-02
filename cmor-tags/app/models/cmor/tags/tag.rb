module Cmor::Tags
  class Tag < ActsAsTaggableOn::Tag
    self.table_name = "tags"
  end
end
