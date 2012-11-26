require "spec_helper"

describe "Board", :js => false do
  before do
    Corkboard.publish!([example_post(:instagram)])
  end

  describe "GET corkboard/board#show" do
    context "when the authentication requirement for 'board' is :disallow!" do
      it "raises an exception" do
        with_config(:authentication, { :board => :disallow! }) do
          expect { visit corkboard.board_path }
            .to raise_error(Corkboard::ActionForbidden)
        end
      end
    end

    context "when the authentication requirement for 'board' is nil" do
      it "is successful" do
        with_config(:authentication, { :board => nil }) do
          visit corkboard.board_path

          expect(page).to have_css('article#corkboard')
          expect(page).to have_css('nav.corkboard.filters')
          expect(page).to have_css('ul.corkboard.posts')
        end
      end
    end

    context "given an authenticated User" do
      before do
        Corkboard::ApplicationController.any_instance
          .stub(:authenticate!).and_return(true)
      end

      it "is successful" do
        with_config(:authentication, { :board => :authenticate! }) do
          visit corkboard.board_path

          expect(page).to have_css('article#corkboard')
          expect(page).to have_css('nav.corkboard.filters')
          expect(page).to have_css('ul.corkboard.posts')
        end
      end
    end

    context "when presentation framework is nil" do
      it "renders with the default DOM" do
        with_config(:presentation, { :framework => nil }) do
          visit corkboard.board_path

          expect(page).to     have_css('nav.corkboard.filters > ul')
          expect(page).to     have_css('nav.corkboard.filters > ul > li:first-child.active')
          expect(page).to_not have_css('nav.corkboard.filters > ul[class]')
        end
      end
    end

    context "when presentation framework is :bootstrap" do
      it "renders with the Bootstrap-enabled DOM" do
        with_config(:presentation, { :framework => :bootstrap }) do
          visit corkboard.board_path

          expect(page).to have_css('nav.corkboard.filters > ul.btn-group')
          expect(page).to have_css('nav.corkboard.filters > ul > li.active.btn')
        end
      end
    end
  end
end
