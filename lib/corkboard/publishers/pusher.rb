require 'pusher'

module Corkboard
  module Publishers
    class Pusher
      attr_reader :credentials

      def initialize(credentials)
        @credentials = credentials
        configure
      end

      def publish!(entry)
        ::Pusher['corkboard'].trigger!('posts/new', {
          :eid     => entry.eid,
          :image   => entry.images.low_resolution.url,
          :caption => (entry.caption ? entry.caption.text : ''),
          :tags    => entry.tags
        })
      end

      private

        def configure
          ::Pusher.app_id = credentials[:client_app]
          ::Pusher.key    = credentials[:client_key]
          ::Pusher.secret = credentials[:client_secret]
        end
    end
  end
end
