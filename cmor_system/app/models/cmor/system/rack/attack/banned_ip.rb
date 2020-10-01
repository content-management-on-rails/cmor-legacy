module Cmor
  module System
    module Rack
      module Attack
        class BannedIp < Cmor::System::ActiveCollection::Base
          self.attribute_names = %w(id key value)

          validates :key, presence: true

          def human
            key
          end

          def self._all
            _keys.collect { |k| new(key: k) }
          end

          def self._store
            ::Rack::Attack.cache.store
          end

          def self._keys
            if _store.is_a?(ActiveSupport::Cache::MemoryStore)
              _store.instance_variable_get(:@data).keys
            elsif _store.is_a?(::Rack::Attack::StoreProxy::RedisCacheStoreProxy)
              _store.redis.keys
            elsif _store.is_a?(::Rack::Attack::StoreProxy::RedisProxy)
              _store.keys
            elsif _store.is_a?(ActiveSupport::Cache::NullStore)
              []
            end.find_all { |k| k.to_s.include?(":ban:") }
          end
          
          def key=(value)
            write_attribute('key', value)
            if value.nil?
              write_attribute('id', nil)
            else
              write_attribute('id', Digest::SHA1.hexdigest(key))
            end
          end

          def destroy
            self.class._store.delete(key)
            self
          end

          def update(attributes)
            self.class._store.write(attributes['key'], attributes['value'])
            if self.key != attributes['key']
              self.class._store.delete(key)
              self.key = attributes['key']
            end
          end

          def persisted?
            key.present? && self.class._keys.include?(key)
          end

          def save
            !!self.class._store.write(attributes['key'], attributes['value'])
          end

          def ip
            return unless key.respond_to?(:split)
            key.split(":").last
          end
        end
      end
    end
  end
end
