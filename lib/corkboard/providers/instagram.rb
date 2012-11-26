require 'instagram'
require 'omniauth-instagram'

module Corkboard
  module Providers
    class Instagram < OmniAuth::Strategies::Instagram
      include Corkboard::Provider

      class << self
        def setup(config)
          settings = config.args.first

          ::Instagram.configure do |c|
            c.client_id     = settings[:client_key]
            c.client_secret = settings[:client_secret]
          end

          [settings[:client_key], settings[:client_secret], { :scope => 'relationships' }]
        end

        def client(options = {})
          # NOTE: we want a new one each time in order to stay trim, and in
          # case of any config changes... via a call to `#setup`.
          Corkboard::Clients::Instagram.new(options)
        end
      end
    end
  end
end
