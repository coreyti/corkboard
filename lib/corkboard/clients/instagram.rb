require 'instagram'

module Corkboard
  module Clients
    class Instagram < ::Instagram::Client
      include Corkboard::Client

      def strategy
        :instagram
      end

      def preload
        user_media_feed(:count => 100)
      end

      def recent
        user_media_feed(:count => 10)
      end

      def subscribe(*args)
        options = args.extract_options!
        create_subscription(*(args + [subscribe_callback] + [options]))
      end
    end
  end
end
