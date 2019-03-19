module Cmor::Tags
  class Tagging < ActsAsTaggableOn::Tagging
    self.table_name = 'taggings'

    def human
      "#{taggable} - #{tag}"
    end

    def taggable=(taggable)
      if taggable.is_a?(String)
        super(GlobalID::Locator.locate(taggable))
      else
        super
      end
    end

    def tagger=(tagger)
      if tagger.is_a?(String)
        super(GlobalID::Locator.locate(tagger))
      else
        super
      end
    end
  end
end
