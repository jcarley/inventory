redis_url = ENV['REDIS_PORT_6379_TCP_ADDR']
namespace = "inventory"

Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://#{redis_url}:6379", :namespace => namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{redis_url}:6379", :namespace => namespace }
end

