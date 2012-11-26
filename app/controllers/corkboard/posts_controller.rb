module Corkboard
  class PostsController < Corkboard::ApplicationController
    def create
      send(:"create_for_#{provider}")
    end

    private

      def provider
        @provider ||= params[:provider]
      end

      def create_for_instagram
        instagram_challenge || instagram_callback || instagram_refresh
      end

      def instagram_challenge
        if request.get? && params['hub.challenge'].present?
          render(:text => params['hub.challenge'])
          return true
        end

        false
      end

      def instagram_callback
        if request.post?
          # TODO: cache "friends"
          # TODO: move to Subscription model
          client  = Corkboard.client(:instagram, { :access_token => instagram_authorization.token })
          friends = client.user_follows.map(&:username)

          ::Instagram.process_subscription(params['_json'].to_json) do |handler|
            handler.on_tag_changed do |tag, change|
              # Get "my" recent feed items... includes updates from my "friends".
              response = client.recent

              # Filter those based on configured "interests".
              relevant = response.data.select do |entry|
                friendly    = friends.include?(entry.user.username)
                interesting = (entry.tags.map(&:intern) & Corkboard.settings(:instagram)[:interests]).present?
                friendly && interesting
              end

              Corkboard.publish!(relevant)
            end
          end

          head :ok and return true
        end

        false
      end

      def instagram_refresh
        if params[:refresh]
          client = Corkboard.client(:instagram, { :access_token => instagram_authorization.token })
          response = client.recent

          Corkboard.publish!(response)

          head :ok and return true
        end

        false
      end

      def instagram_authorization
        @instagram_authorization ||= Corkboard::Authorization.find_by_provider('instagram')
      end
  end
end
