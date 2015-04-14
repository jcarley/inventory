module Elasticsearch
  module Model
    module Adapter
      module NoBrainer

        Adapter.register self, lambda { |klass| defined?(::NoBrainer::Document) and klass.ancestors.include?(::NoBrainer::Document) }

        module Records
          def records
            criteria = klass.where(:id.in => ids)

            # criteria.instance_exec(response.response['hits']['hits']) do |hits|
              # define_singleton_method :to_a do
                # self.entries.sort_by { |e| hits.index { |hit| hit['_id'].to_s == e.id.to_s } }
              # end
            # end

            criteria
          end
        end

        module Importing

          def __find_in_batches(options={}, &block)
            options[:batch_size] ||= 1_000
            items = []

            all.each do |item|
              items << item

              if items.length % options[:batch_size] == 0
                yield items
                items = []
              end
            end

            unless items.empty?
              yield items
            end
          end

          def __transform
            lambda {|a|  { index: { _id: a.id.to_s, data: a.as_indexed_json } }}
          end
        end

        module Callbacks
          def self.included(base)
            base.after_create  { |document| document.__elasticsearch__.index_document  }
            base.after_update  { |document| document.__elasticsearch__.update_document }
            base.after_destroy { |document| document.__elasticsearch__.delete_document }
          end
        end

      end
    end
  end
end

Elasticsearch::Model.client = Elasticsearch::Client.new log: true

