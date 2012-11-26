require "spec_helper"

describe Corkboard do
  before do
    Corkboard.publisher_configs.clear
    Corkboard.service_configs.clear
  end

  describe ".setup" do
    it "yields `self`" do
      expect { |b| Corkboard.setup(&b) }.to yield_with_args(Corkboard)
    end
  end

  describe ".authentication" do
    let(:method) { :auth_method }

    it "merges the provided configuration with defaults" do
      Corkboard.authentication(:board => method)

      expect(Corkboard.authentication).to eq({
        :admin => :disallow!,
        :board => method
      })
    end
  end

  describe ".presentation" do
    let(:title) { Faker::Lorem.sentence }

    it "merges the provided configuration with defaults" do
      Corkboard.presentation(:title => title)

      expect(Corkboard.presentation).to eq({
        :title       => title,
        :description => 'Corkboard',
        :framework   => :bootstrap,
        :weights     => { :s => 10, :m => 3, :l => 1 }
      })
    end
  end

  describe ".interests" do
    let(:scope)   { [:hashtag] }
    let(:filters) { [:one, :two] }

    it "merges the provided configuration with defaults" do
      Corkboard.interests({
        :scope   => scope,
        :filters => filters
      })

      expect(Corkboard.interests).to eq({
        :scope   => scope,
        :filters => filters
      })
    end
  end

  describe ".publisher" do
    before do
      expect(Corkboard.publishers).to be_empty
    end

    it "adds to the list of enabled publication providers" do
      pending
      Corkboard.publisher(:example, 'URL')
      expect(Corkboard.publishers).to eq([:example])
    end
  end

  describe ".publishers" do
    it "is pending" do
      pending
    end
  end

  describe ".publisher_configs" do
    it "is pending" do
      pending
    end
  end

  describe ".service" do
    before do
      expect(Corkboard.services).to be_empty
    end

    it "adds to the list of enabled service providers" do
      Corkboard.service(:example, 'KEY', 'SECRET')
      expect(Corkboard.services).to eq([:example])
    end
  end

  describe ".services" do
    it "is pending" do
      pending
    end
  end

  describe ".service_configs" do
    it "is pending" do
      pending
    end
  end

  describe ".client" do
    it "is pending" do
      pending
    end
  end

  describe ".clear_all!" do
    it "is pending" do
      pending
    end
  end

  describe ".provider_for" do
    it "is pending" do
      pending
    end
  end

  describe ".publisher_for" do
    it "is pending" do
      pending
    end
  end

  describe ".publish!" do
    it "is pending" do
      pending
    end
  end
end
