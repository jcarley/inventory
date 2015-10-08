module Entity
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    include NoBrainer::Document
    include NoBrainer::Document::Timestamps

    # self.send(:after_create) { Storage::Indexer.perform_async(:index, self.id, self.class) }
    # self.send(:after_update) { Storage::Indexer.perform_async(:update, self.id, self.class) }
    # self.send(:after_destroy) { Storage::Indexer.perform_async(:destroy, self.id, self.class) }

    field :uid, type: String
  end

  module ClassMethods

    def build_from(events)
      object = self.new
      events.each do |event|
        object.send :do_apply, event
      end
      object
    end

    def new_uid
      UUIDTools::UUID.timestamp_create.to_s
    end

  end

  def as_indexed_json(options = {})
    as_json
  end

  def get_uid
    self.uid ||= self.class.new_uid
  end

  def applied_events
    @applied_events ||= []
  end

  def apply_event(name, attributes)
    event = Event.new(:name => name, :data => attributes)
    event.aggregate_uid = get_uid
    do_apply event
    applied_events << event
    DomainRepository.save(event)
  end

private

  def do_apply(event)
    method_name = "on_#{event.name.to_s.underscore}".sub(/_event/,'')
    method(method_name).call(event) if respond_to?(method_name)
  end

end

