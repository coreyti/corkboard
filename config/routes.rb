Corkboard::Engine.routes.draw do
  match "/",
    :to   => "board#show",
    :as   => :board

  match "/auth",
    :to   => "authorizations#index",
    :as   => :authorizations,
    :via  => [:get]

  # NOTE: This route entry is purely for the sake of generating the desired
  # url/path helper. In fact, OmniAuth handles the actual request.
  match "/auth/:action",
    :to   => nil,
    :as   => :authorization,
    :via  => [:get]

  match "/auth/:provider/callback",
    :to   => "authorizations#create",
    :via  => [:get, :post]

  match "/auth/:provider",
    :to   => "authorizations#destroy",
    :via  => [:delete]

  match "/posts/:provider/callback",
    :to   => "posts#create",
    :via  => [:get, :post]
end
