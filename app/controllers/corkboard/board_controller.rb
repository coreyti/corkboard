module Corkboard
  class BoardController < Corkboard::ApplicationController
    # GET /:mount_point
    def show
      head :ok
    end
  end
end
