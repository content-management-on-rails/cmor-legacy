module Cmor
  module System
    module Rack
      module Attack
        # TODO: Implement stores:
        #
        # - ActiveSupport::Cache::MemoryStore
        # - ::Rack::Attack::StoreProxy::RedisCacheStoreProxy
        # - ::Rack::Attack::StoreProxy::RedisProxy
        # - ActiveSupport::Cache::NullStore
        #
        class BannedIp < Rao::ActiveCollection::Base
          attr_accessor :id, :key, :value

          validates :key, presence: true

          def self.generate_primary_key(record)
            raise "Could not generate primary key for #{record.inspect}" unless record&.key.present?
            Digest::SHA1.hexdigest(record.key)
          end

          def human
            key
          end

          def ip
            return unless key.respond_to?(:split)
            key.split(":").last
          end

          def update(attributes)
            if attributes.keys.map(&:to_s).include?("key")
              # delete old key
              self.class.find(id).destroy
              # write new key
              save
            else
              super
            end
          end
        end
      end
    end
  end
end
