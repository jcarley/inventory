class Event
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  table_config name: 'domain_events'

  field :name, type: String
  field :class_name, type: String
  field :aggregate_uid, type: String
  field :data, type: Hash
end

