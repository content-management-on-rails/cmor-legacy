module Cmor
  module Configuration
    def configure
      yield self
    end

    def register_configuration(name, configuration)
      (@@configuration ||= {})[name.to_sym] = configuration
    end

    def method_missing(m, *args, &block)
      if @@configuration.has_key?(m.to_sym)
        return @@configuration[m.to_sym]
      else
        super
      end
    end
  end
end