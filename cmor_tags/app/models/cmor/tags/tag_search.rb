module Cmor::Tags
  class TagSearch
    include ActiveModel::Model

    attr_accessor :tag_list, :result, :taggable_classes, :exact

    validates :tag_list, presence: true

    def self.call(*args)
      new(*args).do_work
    end

    def self.i18n_scope
      :activerecord
    end

    def do_work
      say "#{self.class.name} running..."
      output = result
      output.each do |klass, resources|
        say "Found #{resources.size} #{klass.constantize.model_name.human(count: :other)}:", indent: 1
        say resources.inspect, indent: 2
      end
      say 'done'
      output
    end

    def tag_list
      @tag_list ||= ''
    end

    def result
      @result ||= search
    end

    def result!
      @result = nil
      result
    end

    def taggable_classes
      @taggable_classes ||= Cmor::Tags::Tagging.distinct.pluck(:taggable_type)
    end

    def exact
      @exact ||= Cmor::Tags::Configuration.tag_search_exact_default_value
    end

    def exact=(value)
      if Rails.version < '5.1'
        @exact = ActiveRecord::Type::Boolean.new.type_cast_from_database(value)
      else
        @exact = ActiveRecord::Type::Boolean.new.cast(value)
      end
    end

    private

    def say(what, options = {})
      options.reverse_merge!(indent: 0)
      indent = options.delete(:indent)

      puts "#{' ' * indent * 2}#{what}"
    end

    def wild
      @wild ||= !exact
    end

    def any
      @any ||= !exact
    end

    def search
      taggable_classes.each_with_object({}) { |klass, result| result[klass] = klass.constantize.tagged_with(tag_list.split(', '), any: any, wild: wild) }
    end
  end
end
