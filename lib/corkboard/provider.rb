module Corkboard
  # Providers are the heart of Corkboard's aggregation of content.
  # Each provider defined must include this module.
  module Provider
    extend ActiveSupport::Concern

    included do |base|
      base.extend(ActiveModel::Naming)
    end

    module ClassMethods
      def service
        @service ||= self.model_name.element.intern
      end
    end

    def service
      @service ||= self.class.service
    end
  end
end
