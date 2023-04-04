module SeedService
  class Base < Rao::Service::Base
    def _perform
      say "Using #{seed_path} as seed path"
      ActiveRecord::Base.transaction do
        wipe! if @options[:wipe]
        json_files.each do |filename|
          say "Seeding #{filename}"
          import(filename)
        end
      end
    end

    private

    def seed_path
      @seed_path ||= Rails.root.join("db", "seeds")
    end

    def json_files
      @json_files ||= Dir.glob(File.join(seed_path, "*.json")).sort
    end

    def wipe!
      wipe_scopes.each do |scope|
        say "Wiping all #{scope}" do
          scope.destroy_all
        end
      end
    end

    def import(filename)
      say "Importing #{filename}" do
        file = File.read(filename)
        json = JSON.parse(file)
        json.each do |model_name, data|
          import_model_data(model_name, data)
        end
      end
    end

    def import_model_data(model_name, data)
      class_name = map_model_name(model_name)
      say "Processing #{data.size} entries for #{class_name}" do
        data.each do |attributes|
          associations = attributes.select { |key, value| key.to_s.match(/.*\..*/) }
          attributes.except!(*associations.keys)
          record = class_name.constantize.new(map_attributes(class_name, attributes))
          associations.map { |associated, value| associate(record, associated, value) }
          # TODO: refactor this to be less ugly
          record.is_a?(Rao::Service::Base) ? record.perform : record.save!
        rescue => e
          binding.pry
        end
      end
    end

    def model_name_map
      @model_name_map ||= {}
    end

    def map_model_name(model_name)
      model_name_map[model_name]
    end

    def map_attributes(class_name, attributes)
      attributes.each_with_object({}) do |(attribute_name, value), memo|
        key = map_attribute_name(class_name, attribute_name)
        memo[key] = map_attribute_value(class_name, attribute_name, value)
      end
    end

    def map_attribute_name(class_name, attribute_name)
      attribute_name_map[class_name.to_sym].try(:[], attribute_name.to_sym) || attribute_name
    end

    def map_attribute_value(class_name, attribute_name, value)
      mapping = attribute_value_map[class_name.to_sym].try(:[], attribute_name.to_sym)
      return value if mapping.nil?
      if mapping.respond_to?(:call)
        mapping.call(value)
      else
        value
      end
    end

    def attribute_name_map
      @attribute_name_map ||= {}
    end

    def attribute_value_map
      @attribute_value_map ||= {}
    end

    def associate(record, associated, value)
      model_name, attribute_name = associated.split(".")
      class_name = map_model_name(model_name)
      association_name = class_name.underscore.split("/").last || class_name.underscore
      attribute = map_attribute_name(class_name, attribute_name)
      associated_record = class_name.constantize.where(attribute => value).first
      record.send("#{association_name}=", associated_record)
    rescue => e
      binding.pry
    end
  end
end
