require 'omniauth'

module Corkboard
  class Engine < ::Rails::Engine
    isolate_namespace Corkboard

    initializer 'corkboard.providers' do |app|
      app.config.middleware.use(Builder, self) do
        Corkboard.services.each do |service|
          # TODO: handle absence of `.settings` for OmniAuth strategies.
          # TODO: handle absence of `.settings` for Corkboard providers (unconfigured).
          klass = Corkboard.provider_for(service)
          provider(*([klass] + klass.setup(Corkboard.service_configs[service])))
        end
      end
    end

    class Builder < OmniAuth::Builder
      attr_accessor :config

      def initialize(app, config, &block)
        @config = config
        super(app, &block)
      end
    end
  end
end
