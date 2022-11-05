module Cmor::Tags
  class Search < Rao::Service::Base
    class Result < Rao::Service::Result::Base
      attr_accessor :tag_list, :taggable_classes, :exact, :found
    end

    attr_accessor :tag_list, :taggable_classes, :exact

    validates :tag_list, presence: true

    def tag_list
      @tag_list ||= ''
    end

    def taggable_classes
      @taggable_classes ||= Cmor::Tags::Tagging.distinct.pluck(:taggable_type)
    end

    def exact
      @exact ||= Cmor::Tags::Configuration.tag_search_exact_default_value
    end

    def exact=(value)
      @exact = ActiveRecord::Type::Boolean.new.cast(value)
    end

    private

    def _perform
      @result.found = search!
    end

    def wild
      @wild ||= !exact
    end

    def any
      @any ||= !exact
    end

    def search!
      taggable_classes.each_with_object({}) { |klass, result| result[klass] = klass.constantize.tagged_with(tag_list.split(', '), any: any, wild: wild) }
    end
  end
end
