module Corkboard
  module Service
    class Config
      attr_reader :provider, :args

      def initialize(provider, args)
        @provider = provider
        @args     = args
      end
    end
  end
end
