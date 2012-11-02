Corkboard::Engine.routes.draw do
  match "/" => "board#show",
      :as   => :board
end