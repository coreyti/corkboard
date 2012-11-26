module Corkboard
  # Client is ...
  module Client
    extend ActiveSupport::Concern
 
    included do |base|
      base.extend(ActiveModel::Naming)
    end
 
    def strategy
      raise NotImplementedError
    end
 
    def callback_url
      [full_host, script_name, "/posts/#{strategy}/callback", query_string].join
    end
 
    def preload
      raise NotImplementedError
    end
 
    def recent
      raise NotImplementedError
    end
 
    def subscribe(*)
      raise NotImplementedError
    end
 
    def subscribe_callback
      callback_url
    end
 
    private
 
      def full_host
        # TODO...
        OmniAuth.config.full_host
      end
 
      def script_name
        # TODO...
        ''
      end
 
      def query_string
        # TODO...
        ''
      end
  end
end
