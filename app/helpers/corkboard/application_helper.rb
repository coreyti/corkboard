require 'weighted_randomizer'

module Corkboard
  module ApplicationHelper
    def attributes_for(key, custom = {})
      resource = custom.delete(:resource)

      attrs = begin
        if (framework = Corkboard.presentation[:framework]) && framework.present?
          { :class => send(:"classes_for_#{framework}", key) }
        else
          { :class => classes_for_plain(key) }
        end
      end

      attrs.merge!(send(:"data_for_#{key}", resource))

      attrs.tap do |h|
        custom.each do |name, value|
          h[name] = [value, h[name]].join(' ')
        end
      end
    end

    private

      def classes_for_bootstrap(key)
        @_classes_for_bootstrap ||= {
          :filters_list => 'btn-group',
          :filters_item => 'btn'
        }

        @_classes_for_bootstrap[key]
      end

      def classes_for_plain(key)
        @_classes_for_plain ||= {
          :filters_list => nil,
          :filters_item => nil
        }

        @_classes_for_plain[key]
      end

      def data_for_filters_list(*)
        {}
      end

      def data_for_filters_item(*)
        {}
      end

      def data_for_posts_item(post)
        special = (Corkboard.interests[:scope] + [:all])
        tags    = post[:tags].reject { |t| special.include?(t.intern) }

        {
          :class => ['entry', randomizer.sample].join(' '),
          :data  => {
            :eid  => post[:eid],
            :tags => tags.join(' ')
          }
        }
      end

      def randomizer
        @randomizer ||= begin
          WeightedRandomizer.new(Corkboard.presentation[:weights])
        end
      end
  end
end
