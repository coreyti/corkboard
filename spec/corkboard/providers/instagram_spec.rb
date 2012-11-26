require "spec_helper"

describe Corkboard::Providers::Instagram do
  let(:provider) { Corkboard::Providers::Instagram }
  let(:instance) { provider.new(credentials) }
  let(:credentials) do
    OpenStruct.new(:args => [{
      :client_key    => 'EXAMPLE',
      :client_secret => 'EXAMPLE'
    }])
  end

  describe ".service" do
    it "is derived from the Class" do
      expect(provider.service).to eq(:instagram)
    end
  end

  describe ".setup" do
    context "given Instagram credentials" do
      it "configures Instagram" do
        Instagram.should_receive(:configure)
        provider.setup(credentials)
      end

      it "returns settings" do
        expect(provider.setup(credentials))
          .to eq(['EXAMPLE', 'EXAMPLE', { :scope => 'relationships' }])
      end
    end
  end

  describe ".client" do
    it "is pending" do
      pending
    end
  end

  describe "#service" do
    it "is derived from the Class" do
      expect(instance.service).to eq(:instagram)
    end
  end
end
