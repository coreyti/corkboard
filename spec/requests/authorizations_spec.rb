require "spec_helper"

describe "Board", :js => false do
  describe "GET corkboard/authorizations#index" do
    context "when the authentication requirement for 'admin' is :disallow!" do
      it "raises an exception" do
        with_config(:authentication, { :admin => :disallow! }) do
          expect { visit corkboard.authorizations_path }
            .to raise_error(Corkboard::ActionForbidden)
        end
      end
    end

    context "when the authentication requirement for 'admin' is nil" do
      it "is successful" do
        with_config(:authentication, { :admin => nil }) do
          visit corkboard.authorizations_path
          expect(page).to have_content('Activated Services')
          expect(page).to have_content('Available Services')
        end
      end
    end

    context "given an authenticated Admin" do
      before do
        Corkboard::ApplicationController.any_instance
          .stub(:authenticate!).and_return(true)
      end

      it "is successful" do
        with_config(:authentication, { :admin => :authenticate! }) do
          visit corkboard.authorizations_path
          expect(page).to have_content('Activated Services')
          expect(page).to have_content('Available Services')
        end
      end
    end
  end
end
