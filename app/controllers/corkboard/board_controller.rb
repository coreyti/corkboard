module Corkboard
  class BoardController < Corkboard::ApplicationController
    before_filter(:auth_board)

    # GET /:mount_point
    def show
      render(:show, :locals => { :posts => Corkboard::Post.recent })
    end
  end
end
