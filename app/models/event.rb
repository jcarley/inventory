class Event
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  store_in :table => 'domain_events'

  field :name, type: String
  field :aggregate_uid, type: String
  field :data, type: Hash
end

