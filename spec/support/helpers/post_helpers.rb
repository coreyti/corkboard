module Support
  module PostHelpers
    def example_post(service)
      send(:"example_post_for_#{service}")
    end

    def example_post_for_instagram
      Instagram.new.to_mash
    end

    class Instagram
      def to_hash
        {
          "id"       => post_id,
          "link"     => post_url,
          "tags"     => tags,
          "caption"  => {
            "created_time"        => timestamp,
            "text"                => Faker::Lorem.sentence,
            "from"                => {
              "id"                => user_id,
              "username"          => user_name,
              "full_name"         => full_name,
              "profile_picture"   => image_url
            },
            "id"=>"340900468247837201"
          },
          "images"   => {
            "low_resolution"      => {
              "url"               => image_url,
              "width"             => 306,
              "height"            => 306
            },
            "standard_resolution" => {
              "url"               => image_url,
              "width"             => 612,
              "height"            => 612
            },
            "thumbnail"           => {
              "url"               => image_url,
              "width"             => 150,
              "height"            => 150
            }
          },
          "location" => {
            "id"                  => location_id,
            "name"                => location_name,
            "latitude"            => location_lat,
            "longitude"           => location_lng
          },
          "user"     => {
            "id"                  => user_id,
            "username"            => user_name,
            "full_name"           => full_name,
            "bio"                 => "",
            "website"             => "",
            "profile_picture"     => image_url
          }
        }
      end

      def to_json
        JSON.dump(to_hash)
      end

      def to_mash
        Hashie::Mash.new(to_hash)
      end

      def image_url
        @image_url ||= Faker::Internet.http_url
      end

      def location_id
        @location_id ||= "1234567"
      end

      def location_name
        @location_name ||= Faker::Address.city
      end

      def location_lat
        @location_lat ||= Faker::Geolocation.lat
      end

      def location_lng
        @location_lng ||= Faker::Geolocation.lng
      end

      def post_id
        @post_id ||= "123456789123456789_12345678"
      end

      def post_url
        @post_url ||= Faker::Internet.http_url
      end

      def tags
        @tags ||= Faker::Lorem.words
      end

      def timestamp
        @timestamp ||= 1.day.ago.to_i
      end

      def user_id
        @user_id ||= "0987654321"
      end

      def user_name
        @user_name ||= Faker::Internet.user_name
      end

      def full_name
        @full_name ||= Faker::Name.name
      end
    end
  end
end
