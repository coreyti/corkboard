class Corkboard::Post
  class << self
    def recent
      posts = []
      ids   = Corkboard.redis.lrange("corkboard:posts", 0, 100)

      if ids.present?
        keys  = Corkboard.redis.mget(*ids)
        posts = (Corkboard.redis.mget(*keys) || []).compact

        if posts.present?
          posts.map! { |post| JSON.parse(post.sub(/^[0-9]+\|/, '')).with_indifferent_access }
        end
      end

      posts
    end
  end
end
