module Model
  module FlagFromTimeRangeConcern
    extend ActiveSupport::Concern

    class_methods do
      def flag_from_time_range(*args)
        options = args.extract_options!
        attributes = args

        attributes.each do |attribute|
          method_name_base = attribute.to_s.chomp('?')
          define_method attribute do
            time_range = (send("#{method_name_base}_from")..send("#{method_name_base}_to"))
            time_range.cover? Time.zone.now
          end

          define_singleton_method method_name_base do
            t = arel_table
            now = Time.zone.now
            where(t["#{method_name_base}_from"].lteq(now)).where(t["#{method_name_base}_to"].gteq(now))
          end
        end
      end
    end
  end
end