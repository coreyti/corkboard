require "spec_helper"

describe Corkboard::BoardController do
  describe "GET #show" do
    it "is successful" do
      get(:show)
      expect(response).to be_success
    end
  end
end
