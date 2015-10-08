module Storage
  class Indexer
    include Sidekiq::Worker
    sidekiq_options queue: 'elasticsearch', retry: false

    addr = ENV['SEARCH_PORT_9200_TCP_ADDR']
    port = ENV['SEARCH_PORT_9200_TCP_PORT']

    Logger = Sidekiq.logger.level == Logger::DEBUG ? Sidekiq.logger : nil
    Client = Elasticsearch::Client.new host: "#{addr}:#{port}", logger: Logger

    def perform(operation, record_id, model_type)
      logger.debug [operation, "ID: #{record_id}"]

      clazz = model_type.to_s.camelize.constantize
      index = clazz.name.tableize
      type = index.singularize

      case operation.to_s
      when /index/
        record = clazz.find(record_id)
        Client.index  index: index, type: type, id: record.id, body: record.as_indexed_json
      when /update/
        record = clazz.find(record_id)
        Client.update  index: index, type: type, id: record.id, body: record.as_indexed_json
      when /delete/
        Client.delete index: index, type: type, id: record_id
      else raise ArgumentError, "Unknown operation '#{operation}'"
      end
    end
  end
end
