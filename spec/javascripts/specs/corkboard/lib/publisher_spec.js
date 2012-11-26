describe("corkboard/lib/publisher.js", function() {
  it("defines $.corkboard.Publisher", function() {
    expect($.corkboard.Publisher).toBeDefined();
  });

  describe("Publisher", function() {
    var mocks;
    var constructor = $.corkboard.Publisher;

    before(function() {
      mocks = {
        channel : {
          bind : function() {}
        },
        pusher : {
          bind      : function() {},
          subscribe : function() { return mocks.channel }
        }
      };
    });

    describe("constructor", function() {
      context("given a valid container for the 'board' content", function() {
        before(function() {
          fixture('board.html', true);
          spyOn(window, 'Pusher').andReturn(mocks.pusher);
        });

        it("opens a Pusher channel for the content updates", function() {
          var instance = new constructor($('#corkboard'));
          expect(window.Pusher).toHaveBeenCalledWith($.corkboard.config.pusher);
        });

        it("retains a reference to the 'board'", function() {
          var instance = new constructor($('#corkboard'));
          expect(instance.board).toBe('#corkboard');
        });

        context("and given a callback", function() {
          it("retains a reference to the callback", function() {
            var callback = function callback() {};
            var instance = new constructor($('#corkboard'), callback);
            expect(instance.callback).toEqual(callback);
          });
        });
      });

      context("given an invalid selector for the 'board' content", function() {
        before(function() {
          spyOn(window, 'Pusher');
        });

        it("does nothing", function() {
          var instance = new constructor($('#corkboard'));
          expect(window.Pusher).not.toHaveBeenCalled();
          expect(instance.board).not.toBeDefined();
        });
      });
    });

    describe("#publish", function() {
      before(function() {
        fixture('board.html', true);
        spyOn(window, 'Pusher').andReturn(mocks.pusher);
      });

      context("given JSON for a new post", function() {
        var json;

        before(function() {
          json = {
            eid     : 'EXAMPLE',
            tags    : 'EXAMPLE',
            caption : 'EXAMPLE',
            image   : '/assets/corkboard/image.png'
          };
        });

        it("renders a tile for the post", function() {
          var instance = new constructor($('#corkboard'));
          expect($('#corkboard li')).not.toExist();

          instance.publish(json);
          expect($('#corkboard li')).toExist();
        });

        context("and given a registered callback", function() {
          it("executes the callback, passing the list of posts as an argument", function() {
            var callback = jasmine.createSpy('callback');
            var instance = new constructor($('#corkboard'), callback);

            instance.publish(json);
            expect(callback).toHaveBeenCalled();
            expect(callback.mostRecentCall.args[0]).toBe('ul.corkboard.posts');
            expect(callback.mostRecentCall.args[1]).toBe('li.entry');
          });
        });
      });
    });
  });
});
