require "spec_helper"
 
describe "Board", :js => true do
  describe "GET corkboard/board#show" do
    it "is successful" do
      visit corkboard.board_path
    end
  end
end
