require "spec_helper"

describe Corkboard::AuthorizationsController do
  describe "GET corkboard/authorizations#index" do
    context "when the authentication requirement for 'admin' is :disallow!" do
      it "raises an exception" do
        with_config(:authentication, { :admin => :disallow! }) do
          expect { get(:index) }
            .to raise_error(Corkboard::ActionForbidden)
        end
      end
    end
  end

  describe "GET corkboard/authorizations#create" do
    it "is pending" do
      pending
    end
  end

  describe "GET corkboard/authorizations#destroy" do
    it "is pending" do
      pending
    end
  end
end
