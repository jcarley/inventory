module Services
  class CacheStore

    attr_reader :db, :namespace, :seperator

    def initialize(namespace = "")
      @namespace = namespace
      @seperator = "."
    end

    def []=(key, value)
      set(key, value)
    end

    def [](key)
      get(key)
    end

    def set(key, value)
      connection.set(store_key(key), value.to_json)
    end

    def get(key)
      JSON.parse(connection.get(store_key(key)) || '{}')
    end
    alias_method :fetch, :get

    def delete(key)
      connection.del(store_key(key))
    end

    def exists?(key)
      connection.get(store_key(key)) != nil
    end
    alias_method :has_key?, :exists?

    def store_key(key)
      store_key = "#{namespace.to_s}#{seperator}#{key.to_s}"
    end

    def count
      self.keys.count
    end

    def keys
      connection.keys("#{namespace.to_s}#{seperator}*").map do |key|
        key.split(seperator)[1]
      end
    end

    private

    def connection
      @redis ||= Redis.new(:host => "localhost", :port => 6379, :db => 15)
    end

  end
end
