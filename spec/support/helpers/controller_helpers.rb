module Support
  module ControllerHelpers
    extend ActiveSupport::Concern

    # Wrap `ActionController::TestCase::Behavior` actions with routing fixes
    # for engine development.
    def process(*args)
      args[1] = (args[1] || {}).merge({ :use_route => :corkboard })
      super(*args)
    end
  end
end
