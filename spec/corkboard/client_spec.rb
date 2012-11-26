require "spec_helper"

describe Corkboard::Client do
  let(:client)   { empty_client }
  let(:instance) { client.new }

  describe "#strategy" do
    it "is pending" do
      pending
    end
  end

  describe "#callback_url" do
    it "is pending" do
      pending
    end
  end

  describe "#preload" do
    it "is pending" do
      pending
    end
  end

  describe "#recent" do
    it "is pending" do
      pending
    end
  end

  describe "#subscribe" do
    it "is pending" do
      pending
    end
  end

  describe "#subscribe_callback" do
    it "is pending" do
      pending
    end
  end

  def empty_client
    @empty_client ||= Class.new do
      include Corkboard::Client

      def self.name
        'Example'
      end
    end
  end
end
