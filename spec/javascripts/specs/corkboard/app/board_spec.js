describe("corkboard/app/corkboard.js", function() {
  it("defines $.corkboard.Board", function() {
    expect($.corkboard.Board).toBeDefined();
  });

  describe("Board", function() {
    describe("constructor", function() {
      var constructor = $.corkboard.Board;

      context("given a valid jQuery object for the 'board' content", function() {
        before(function() {
          fixture('board.html', true);
          spyOn($.corkboard, 'Publisher');
        });

        it("creates a Publisher instance for the board", function() {
          var publisher = $.corkboard.Publisher;
          var instance  = new constructor($('#corkboard'));

          expect(publisher).toHaveBeenCalled();
          expect(publisher.mostRecentCall.args[0]).toBe('article#corkboard');
          expect(publisher.mostRecentCall.args[1]).toEqual(instance.updated);
        });
      });

      context("given an invalid (zero-length) jQuery object for the 'board' content", function() {
        before(function() {
          spyOn($.corkboard, 'Publisher');
        });

        it("does nothing", function() {
          var instance = new constructor($('#corkboard'));
          expect($.corkboard.Publisher).not.toHaveBeenCalled();
        });
      });
    });

    describe("#updated", function() {
      context("called with the updated posts container and a list of new entries", function() {
        var instance, posts, entry;
        var constructor = $.corkboard.Board;

        before(function() {
          fixture('board.html', true);
          spyOn($.corkboard, 'Publisher');

          instance = new constructor($('#corkboard'));
          posts    = $('ul.corkboard.posts');
          entry    = $('<li class="entry">').appendTo(posts);
        });

        it("updates the layout", function() {
          spyOn(posts, 'masonry');

          instance.updated(posts, entry);
          expect(posts.masonry).toHaveBeenCalled();
        });

        it("reveals the entries", function() {
          spyOn(entry, 'fadeIn');

          instance.updated(posts, entry);
          expect(entry.fadeIn).toHaveBeenCalledWith('slow');
        });
      });
    });
  });
});
