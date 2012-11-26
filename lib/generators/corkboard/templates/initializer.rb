# Use this hook to configure Corkboard.
Corkboard.setup do |config|
  # OmniAuth and Redis configuration.
  # ---------------------------------------------------------------------------
  OmniAuth.config.full_host = 'http://www.example.com'
  config.redis = Redis.connect(:url => ENV['REDIS_URL'])

  # Authentication: who can see what.
  # ---------------------------------------------------------------------------
  config.authentication({
    :admin         => :authenticate_admin!, # use `false` to disable auth.
    :board         => :authenticate_user!   # use `false` to disable auth.
  })

  # Interests: the hashtags to look for and filter by.
  # ---------------------------------------------------------------------------
  config.interests({
    :scope         => [:hashtag],
    :filters       => [:other_hashtag]
  })

  # Presentation: display stuff.
  # ---------------------------------------------------------------------------
  config.presentation({
    :title         => 'Example title',
    :description   => 'Example description',
    :framework     => :bootstrap,
    :weights       => { :s => 10, :m => 3, :l => 1 }
  })

  # Publishers: send to the browser.
  # ---------------------------------------------------------------------------
  config.publisher(:pusher, {
    :client_app    => ENV['PUSHER_APP'],
    :client_key    => ENV['PUSHER_KEY'],
    :client_secret => ENV['PUSHER_SECRET']
  })

  # Services: pull from social networks.
  # ---------------------------------------------------------------------------
  config.service(:instagram, {
    :client_key    => ENV['INSTAGRAM_KEY'],
    :client_secret => ENV['INSTAGRAM_SECRET']
  })
end
