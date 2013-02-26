(function($, corkboard) {
  // TODO: allow for and handle multiple matches.
  function Board(board) {
    if(board.length) {
      this.setup(board);
    }
  }

  // Surfaced as part of the corkboard namespace.
  corkboard.Board = Board;

  // TODO: consider making selectors configurable.
  // TODO: make the masonry configuration configurable.
  // TODO: add specs (and break up).
  Board.prototype.setup = function setup(board) {
    var selectors = {
      posts   : 'ul.corkboard.posts',
      entry   : 'li.entry',
      filters : 'nav.corkboard.filters'
    };
    var posts   = $(selectors.posts, board);
    var filters = $(selectors.filters);

    posts.imagesLoaded(function() {
      this.masonry({
        isAnimated   : true,
        isFitWidth   : true,
        itemSelector : selectors.entry + ':not(.hidden)',

        columnWidth : function columnWidth(containerWidth) {
          if(containerWidth <= 320) {
            return 160;
          }
          if(containerWidth <= 480) {
            return 182;
          }
          else if(containerWidth <= 768){
            return 140;
          }
          else {
            return 172;
          }
        }
      });

      // reveal tiles in a pseudo-scattered pattern.
      this.find([selectors.entry, ':nth-child(5n+1)'].join('')).fadeIn(function callback() {
        var next = $(this).next();

        if( ! next.is(':visible')) {
          next.fadeIn(corkboard.config('fade'), callback);
        };
      });
    });

    // TODO: generalize filter placement (to other-than-FAB)
    filters.on('click', 'a', function(e) {
      var link    = $(this);
      var href    = link.attr('href');
      if (!href || href=='#') return false;  // do nothing if href empty
      var filters = $('li', selectors.filters);
      var filter  = link.parent().toggleClass('active');
      var posts   = $(selectors.posts);
      var entries = posts.find(selectors.entry);
      var tag     = href.replace('#', '');

      filters.not(filter).removeClass('active');

      if(link.hasClass('all') || ( ! filter.hasClass('active'))) {
        $('a.all').parent().addClass('active');
        posts.masonry('filter', entries, '*');
      }
      else {
        posts.masonry('filter', entries, '[data-tags~="' + tag + '"]');
      }

      return false;
    });

    new corkboard.Publisher(board, this.updated);
  };

  Board.prototype.updated = function updated(list, added) {
    list.masonry('reload');
    added.fadeIn(corkboard.config('fade'));
  };
})(jQuery, jQuery.corkboard);
