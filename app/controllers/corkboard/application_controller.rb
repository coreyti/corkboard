module Corkboard
  class ApplicationController < ActionController::Base
    def auth_admin
      send(Corkboard.authentication[:admin]) if Corkboard.authentication[:admin]
    end

    def auth_board
      send(Corkboard.authentication[:board]) if Corkboard.authentication[:board]
    end

    def disallow!
      raise Corkboard::ActionForbidden
    end
  end
end
