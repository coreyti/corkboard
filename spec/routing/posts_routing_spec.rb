require "spec_helper"

describe "Routing for Posts" do
  it "maps GET ':mount_point/posts/:provider/callback' to #create" do
    expect(:get => '/posts/example/callback').to route_to('corkboard/posts#create', {
      :provider => 'example'
    })
  end

  it "maps POST ':mount_point/posts/:provider/callback' to #create" do
    expect(:post => '/posts/example/callback').to route_to('corkboard/posts#create', {
      :provider => 'example'
    })
  end
end
