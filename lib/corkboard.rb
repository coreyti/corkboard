require 'corkboard/engine'
require 'omniauth'
require 'redis'

module Corkboard
  class ActionForbidden < StandardError ; end

  autoload :Client,      'corkboard/client'
  autoload :Provider,    'corkboard/provider'

  module Clients
    autoload :Instagram, 'corkboard/clients/instagram'
  end

  module Providers
    autoload :Instagram, 'corkboard/providers/instagram'
  end

  module Publishers
    autoload :Mock,      'corkboard/publishers/mock'
    autoload :Pusher,    'corkboard/publishers/pusher'
  end

  module Service
    autoload :Config,    'corkboard/service/config'
  end

  # The standard mechanism for configuring Corkboard. Run the following to
  # generate a fresh initializer with configuration defaults and samples:
  #
  #     rails generate corkboard:install
  #
  def self.setup
    yield self
  end

  # Public Configuration
  # ---------------------------------------------------------------------------

  # Redis connection.
  mattr_accessor :redis
  @@redis = nil

  # Authentication defaults.
  @@authentication = {
    :admin => :disallow!,
    :board => nil
  }

  # Authentication configuration.
  def self.authentication(config = nil)
    if config
      @@authentication.merge!(config)
    end

    @@authentication
  end

  # Presentation/view defaults.
  @@presentation = {
    :title       => 'Corkboard',
    :description => 'Corkboard',
    :framework   => :bootstrap,
    :weights     => { :s => 10, :m => 3, :l => 1 }
  }

  # Presentation/view configuration.
  def self.presentation(config = nil)
    if config
      @@presentation.merge!(config)
    end

    @@presentation
  end

  # Interests defaults.
  @@interests = {
    :scope   => [],
    :filters => [],
  }

  # Interests configuration.
  def self.interests(config = nil)
    if config
      @@interests.merge!(config)
    end

    @@interests
  end

  # Enable and configure a publisher.
  #
  #     config.publisher(:pusher, {
  #       :client_app    => 'EXAMPLE',
  #       :client_key    => 'EXAMPLE',
  #       :client_secret => 'EXAMPLE'
  #     })
  #
  def self.publisher(provider, credentials = nil)
    @@publisher_configs[provider] = publisher_for(provider).new(credentials)
  end

  # Providers for enabled publishers.
  def self.publishers
    publisher_configs.keys
  end

  # Publication provider configurations.
  mattr_accessor :publisher_configs
  @@publisher_configs = ActiveSupport::OrderedHash.new

  # Enable and configure a service.
  #
  #     config.service(:instagram,
  #       :client_key    => 'EXAMPLE',
  #       :client_secret => 'EXAMPLE'
  #     })
  #
  def self.service(provider, *args)
    config = Corkboard::Service::Config.new(provider, args)
    @@service_configs[provider] = config
  end

  # Service provider configurations.
  mattr_accessor :service_configs
  @@service_configs = ActiveSupport::OrderedHash.new

  # Providers for enabled services.
  def self.services
    service_configs.keys
  end

  # Publishing methods (will likely move elsewhere)
  # ---------------------------------------------------------------------------

  def self.client(strategy, options = {})
    provider_for(strategy).client(options)
  end

  def self.clear_all!
    keys   = Corkboard.redis.keys("corkboard:*")
    Corkboard.redis.del(keys) if keys.present?
  end

  def self.provider_for(key)
    Corkboard::Providers.const_get(camelcase(key))
  end

  def self.publisher_for(key)
    Corkboard::Publishers.const_get(camelcase(key))
  end

  # TODO: make non-specific to instagram.
  # TODO: post `data` as a collection (fewer http requests sent)
  def self.publish!(data)
    received = Time.now.utc.to_i

    data.reverse.each do |item|
      eid   = item.id
      key   = "corkboard:posts:instagram:#{eid}"
      entry = Hashie::Mash.new({
        :eid       => eid,           # String
        :caption   => item.caption,  # Mash [:text]
        :images    => item.images,   # Mash [:low_resolution, standard_resolution, :thumbnail]
        :link      => item.link,     # String
        :location  => item.location, # Mash
        :tags      => item.tags,     # Array
        :user      => item.user      # Mash [:id, :username]
      })

      if Corkboard.redis.setnx(key, "#{received}|#{entry.to_json}")
        position  = Corkboard.redis.incr("corkboard:counters:post")
        reference = "corkboard:posts:#{position}"

        Corkboard.redis.set(reference, key)
        Corkboard.redis.lpush("corkboard:posts", reference)
        Corkboard.redis.ltrim("corkboard:posts", 0, 1000)

        publishers.each do |name|
          publisher_configs[name].publish!(entry)
        end
      end
    end
  end

  private

    def self.camelcase(value)
      OmniAuth::Utils.camelize(value.to_s)
    end
end
