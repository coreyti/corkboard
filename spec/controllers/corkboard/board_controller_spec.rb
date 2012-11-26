require "spec_helper"

describe Corkboard::BoardController do
  describe "GET #show" do
    it "is successful" do
      pending

      get(:show)
      expect(response).to be_success
    end

    it "renders :show" do
      pending
    end

    it "passes :locals" do
      pending
    end

    context "when the authentication requirement for 'board' is :disallow!" do
      it "raises an exception" do
        with_config(:authentication, { :board => :disallow! }) do
          expect { get(:show) }
            .to raise_error(Corkboard::ActionForbidden)
        end
      end
    end
  end
end
