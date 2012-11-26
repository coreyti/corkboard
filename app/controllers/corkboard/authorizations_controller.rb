module Corkboard
  class AuthorizationsController < Corkboard::ApplicationController
    before_filter(:auth_admin, {
      :except => [:create]
    })

    # GET  /:mount_point/authorizations
    def index
      authorizations = Corkboard::Authorization.all
      providers      = authorizations.map(&:provider)
      available      = Corkboard.services.reject { |s| providers.include?(s) }

      render(:index, :locals => {
        :activated => authorizations,
        :available => available
      })
    end

    # GET  /:mount_point/auth/:provider/callback
    # POST /:mount_point/auth/:provider/callback
    def create
      # TODO:
      #   * guard based on "state" param:
      #     if `session['omniauth.state]`, `params[:state]` must match.

      authorization = Corkboard::Authorization.create!(auth_attrs)
      subscription  = Corkboard::Subscription.create!(provider, authorization)

      Corkboard.publish!(subscription.backlog)
      redirect_to(authorizations_path)
    end

    # DELETE /:mount_point/auth/:provider
    def destroy
      # TODO: resolve the fact that there may be more than one for the same
      # provider.  either disallow multiple, or select the correct one.
      auth = Corkboard::Authorization.find_by_provider(params[:provider])
      auth.destroy if auth
      Corkboard.clear_all!

      redirect_to(authorizations_path)
    end

    private

      def auth_attrs
        @auth_attrs ||= {
          :resource_owner => nil, # TODO
          :provider       => auth_params.provider,
          :uid            => auth_params.uid,
          :token          => auth_params.credentials.token,
          :info           => auth_params.info,
          :extra          => auth_params.extra
        }
      end

      def auth_params
        @auth_params ||= request.env['omniauth.auth']
      end

      def provider
        @provider ||= params[:provider]
      end
  end
end
