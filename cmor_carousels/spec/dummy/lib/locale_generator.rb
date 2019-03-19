class Hash
  def dig(*path)
    path.inject(self) do |location, key|
      location.respond_to?(:keys) ? location[key] : nil
    end
  end
end

class LocaleGenerator
  attr_accessor :model_constant, :instance, :existing_content, :locale, :new_locale

  def initialize(model_constant, locale)
    @model_constant = model_constant
    @locale = locale
    @instance = @model_constant.new
    @existing_content = {}
    @new_locale = true

    load_file
  end

  # Gets the attribute names from the active record model without 'id'
  def new_attribute_translation_keys
    model_constant.attribute_names.sort.delete_if {|key, value| key == 'id' }
  end

  # Returns a hash with attribute names and empty translations
  def new_attributes_hashed
    new_attribute_translation_keys.reduce({}) { |h, a| h.merge({ a => nil} ) }
  end

  # Returns the model name for the translation hash
  def model_name_for_translation
    model_constant.to_s.underscore
  end

  # fresh from the database
  def new_translations_full_hash
    {
      locale.to_s => {
        "activerecord" => {
          "attributes" => {
            model_name_for_translation => new_attributes_hashed
          },
          "models" => {
            model_name_for_translation => {
              "one" => nil,
              "other" => nil
            }
          }
        }
      }
    }
  end

  # returns a hash with new attributes
  def new_translations_attributes
    new_translations_full_hash.dig(locale.to_s, 'activerecord', 'attributes', model_name_for_translation)
  end

  # returns an array with new attribute names
  def new_translations_attributes_keys
    new_translations_attributes.keys
  end

  # returns a hash with new model names
  def new_translations_model_names
    new_translations_full_hash.dig(locale.to_s, 'activerecord', 'models', model_name_for_translation)
  end

  # returns an array with new model names
  def new_translations_model_name_keys
    new_translations_model_names.keys
  end

  # creates a suiting filename for the model
  def filename
    File.join("config", "locales", model_constant.to_s.underscore.gsub('/', '.') + "." + locale.to_s + ".yml")
  end

  # loads the translations from file
  def load_file
    return false unless File.exists?(filename)
    self.existing_content = YAML.load_file(filename)
    self.new_locale = false
    return true
  end

  # Returns true if no suiting locale file was found
  def new_locale?
    new_locale
  end

  # Saves the merged translations to a locale file
  def save_file
    File.open(filename, 'w') do |out|
      YAML.dump(merged_translations_full_hash, out)
    end
  end

  # Returns the complete hash of existing (loaded) translations
  def existing_translations_full_hash
    existing_content
  end

  # Returns a hash with the existing attribute translations
  def existing_translations_attributes
    existing_translations_attributes = existing_content.dig(locale.to_s, 'activerecord', 'attributes', model_name_for_translation) if existing_content.respond_to?(:dig)
    if existing_translations_attributes.nil?
      return {}
    else
      return existing_translations_attributes
    end
  end

  # Returns a hash with the existing model names
  def existing_model_names
    existing_model_names = existing_content.dig(locale.to_s, 'activerecord', 'models', model_name_for_translation) if existing_content.respond_to?(:dig)
    if existing_model_names.nil?
      return { "one" => nil, "other" => nil }
    else
      return existing_model_names
    end
  end

  # Returns an array with the existing attribute keys
  def existing_translations_attributes_keys
    existing_translations_attributes.keys
  end

  # Returns an array with the existing model_names
  def existing_model_names_keys
    existing_model_names.keys
  end

#  # Returns the hash with existing (loaded) model names or an empty hash.
#  def existing_translations_model_names
#    existing_translations_model_names = existing_translations_full_hash.dig(locale.to_s, "activerecord", "models")
#    if existing_translations_model_names.nil?
#      return {}
#    else
#      return existing_translations_model_names
#    end
#  end

  # returns new attribute keys that are not present in the existent (loaded) attribute keys.
  def new_attribute_keys
    new_translations_attributes_keys - existing_translations_attributes_keys
  end

  # returns the number of new attribute keys
  def has_new_attribute_keys
    new_attribute_keys.size > 0
  end

  # returns new model names that are not present in the existent (loaded) model names.
  def new_model_names
    new_translations_model_name_keys - existing_model_names_keys
  end

  # returns the number of new attribute keys
  def has_new_model_names
    new_model_names.size > 0
  end

  # TODO: Add methods to merge existing and new attribs
  def merged_translations_attributes_keys
    (existing_translations_attributes_keys + new_translations_attributes_keys).uniq
  end

  def merged_translations_attributes
    existing_translations_attributes.merge( new_attribute_keys.reduce({}) { |h, a| h.merge({ a => nil }) } )
  end

  def merged_model_names
    existing_model_names.merge( new_model_names.reduce({}) { |h, a| h.merge({ a => nil }) } )
  end

  def merged_translations_full_hash
    {
      locale.to_s => {
        "activerecord" => {
          "attributes" => {
            model_name_for_translation => merged_translations_attributes
          },
          "models" => {
            model_name_for_translation => merged_model_names
          }
        }
      }
    }
  end
end

