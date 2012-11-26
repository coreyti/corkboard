require "spec_helper"

describe Corkboard::Providers do
  let(:provider) { empty_provider }
  let(:instance) { provider.new }

  describe ".service" do
    it "is derived from the Class" do
      expect(provider.service).to eq(:example)
    end
  end

  describe "#service" do
    it "is derived from the Class" do
      expect(instance.service).to eq(:example)
    end
  end

  def empty_provider
    @empty_provider ||= Class.new do
      include Corkboard::Provider

      def self.name
        'Example'
      end
    end
  end
end
