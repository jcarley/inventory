require 'rails_helper'

RSpec.describe AssetRepository do

  describe "#create" do

    it "returns a new record" do
      repo = AssetRepository.new
      record = repo.create(:name => "Foo")
      aggregate_failures "testing record" do
        expect(record).to be_instance_of(Asset)
        expect(record.name).to eql "Foo"
        expect(record).to be_new_record
        expect(record).to be_changed
      end
    end

    it "adds an uncommitted created event" do
      repo = AssetRepository.new
      record = repo.create(:name => "Foo")
      event = record.applied_events.first
      aggregate_failures "testing event" do
        expect(event).to be_instance_of(Event)
        expect(event.name).to eql "asset_created_event"
      end
    end

  end

  describe "#delete_by" do

    it "deletes a record by id" do
      original_record = FactoryGirl.create(:asset)
      repo = AssetRepository.new
      expected_record = repo.delete_by(original_record.id)
      aggregate_failures "testing expected_record" do
        expect(expected_record).to be_destroyed
      end
    end

  end

  describe "#delete" do

    it "deletes the record" do
      original_record = FactoryGirl.create(:asset)
      repo = AssetRepository.new
      repo.delete(original_record)
      aggregate_failures "original_record" do
        expect(original_record).to be_deleted
        expect(original_record).to_not be_changed
        expect(original_record).to_not be_destroyed
      end
    end

    it "adds an destroyed event" do
      original_record = FactoryGirl.create(:asset)
      repo = AssetRepository.new
      repo.delete(original_record)
      event = original_record.applied_events.first
      aggregate_failures "testing event" do
        expect(event).to be_instance_of(Event)
        expect(event.name).to eql "asset_destroyed_event"
      end
    end

    it "is destroyed on save" do
      original_record = FactoryGirl.create(:asset)
      repo = AssetRepository.new
      repo.delete(original_record)
      repo.save(original_record)
      expect(original_record).to be_destroyed
    end

  end

  describe "#modify" do

    it "applies the changes to the record" do
      original_record = FactoryGirl.create(:asset)
      repo = AssetRepository.new
      repo.modify(original_record, :name => "Bob")
      aggregate_failures "testing original_record" do
        expect(original_record.name).to eql("Bob")
        expect(original_record).to be_changed
      end
    end

    it "commits the changes" do
      original_record = FactoryGirl.create(:asset)
      repo = AssetRepository.new
      repo.modify(original_record, :name => "Bob")
      repo.save(original_record)
      aggregate_failures "testing original_record" do
        expect(original_record.name).to eql("Bob")
        expect(original_record).to_not be_changed
      end
    end

  end

end
