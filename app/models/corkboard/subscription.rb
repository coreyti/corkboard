class Corkboard::Subscription
  class << self
    def create!(provider, authorization)
      client       = Corkboard.client(provider, { :access_token => authorization.token })
      subscription = self.new(client)

      # TODO: make non-specific to Instagram.
      Corkboard.interests[:scope].each do |interest|
        client.subscribe('tag', { :object_id => "#{interest}" })
      end

      subscription
    end
  end

  attr_reader :client

  def initialize(client)
    @client = client
  end

  def backlog
    # TODO: make non-specific to Instagram.
    friends  = client.user_follows.map(&:username)
    response = client.preload

    # Filter those based on configured "interests".
    response.data.select do |entry|
      friendly    = friends.include?(entry.user.username)
      interesting = (entry.tags.map(&:intern) & Corkboard.interests[:scope]).present?
      friendly && interesting
    end
  end
end
