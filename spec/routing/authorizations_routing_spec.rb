require "spec_helper"

describe "Routing for Authorizations" do
  it "maps GET ':mount_point/auth' to #index" do
    expect(:get => '/auth').to route_to('corkboard/authorizations#index')
  end

  it "maps GET ':mount_point/auth/:provider/callback' to #create" do
    expect(:get => '/auth/example/callback').to route_to('corkboard/authorizations#create', {
      :provider => 'example'
    })
  end

  it "maps POST ':mount_point/auth/:provider/callback' to #create" do
    expect(:post => '/auth/example/callback').to route_to('corkboard/authorizations#create', {
      :provider => 'example'
    })
  end

  it "maps DELETE ':mount_point/auth/:provider' to #destroy" do
    expect(:delete => '/auth/example').to route_to('corkboard/authorizations#destroy', {
      :provider => 'example'
    })
  end
end
