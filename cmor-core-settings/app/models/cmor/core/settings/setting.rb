module Cmor::Core::Settings
  class Setting < ApplicationRecord
    attr_accessor :default, :validations
    
    validates :namespace, presence: true
    validates :key, presence: true, uniqueness: { scope: :namespace }

    after_initialize :set_defaults
    after_initialize :update_validations

    # before_save :run_singleton_class_validations

    def validations=(value)
      @validations = value
      update_validations
    end

    def run_singleton_class_validations
      # binding.pry
      # valid?(on: id)

      self.singleton_class.validators.each do |validator|
        validator.validate(self)
      end
    end

    private

    def set_defaults
      @validations ||= {}
    end

    def update_validations
      return unless validations.is_a?(Hash)
      remove_validations_on_value
      # add validations to the eigenclass
      validations.each do |validation, options|
        # next if validation_exists?(validation, options)
        if options.is_a?(Hash)
          self.singleton_class.send("validates_#{validation}_of", :value, options)
          # self.singleton_class.send("validates_#{validation}_of", :value, options.merge(on: id))
        else
          self.singleton_class.send("validates_#{validation}_of", :value)
          # self.singleton_class.send("validates_#{validation}_of", :value, on: id)
        end
      end
    end

    def remove_validations_on_value
      self.singleton_class.validators.each do |validator|
        self.singleton_class.validators.delete(validator) if validator.attributes.include?(:value)
      end
    end

    def validation_exists?(validation, options)
      validation_for_comparison = "ActiveRecord::Validations::#{validation.to_s.camelize}Validator"
      self.singleton_class.validators.map { |v| [v.class.name, v.attributes] }.include?([validation_for_comparison, [:value]])
    end
  end
end
