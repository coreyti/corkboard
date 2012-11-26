module Corkboard
  module Publishers
    class Mock
      def initialize(*)
        # no-op
      end

      # TODO: store in memory
      def publish!(entry)
        # no-op (for now)
      end
    end
  end
end
