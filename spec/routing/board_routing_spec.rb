require "spec_helper"

describe "Routing for Board" do
  it "maps GET ':mount_point' to #show" do
    expect(:get => '/').to route_to('corkboard/board#show')
  end
end
