module Cmor
  module Core
    class Feature
      def initialize(name, options = {})
        @name, @options = name, options
      end
    end
  end
end