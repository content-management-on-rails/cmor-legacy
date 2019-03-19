module Cmor
  module Suite
    module Configuration
      def configure
        yield self
      end

      def administrador
        Administrador
      end

      def cmor_core
        Cmor::Core
      end

      def cmor_core_backend
        Cmor::Core::Backend
      end
    end
  end
end