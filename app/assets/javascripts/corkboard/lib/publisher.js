(function($, corkboard) {
  function Publisher(board, callback) {
    if(board.length) {
      this.board    = board;
      this.callback = callback;
      this.subscribe();
    }
  }

  // Surfaced as part of the corkboard namespace.
  corkboard.Publisher = Publisher;

  Publisher.prototype.subscribe = function subscribe() {
    var self    = this;
    var pusher  = new Pusher(corkboard.config.pusher);
    var channel = pusher.subscribe('corkboard');

    // pusher.bind('pusher:error', function(data) {
    //   alert(data);
    // });

    channel.bind('posts/new', function(data) {
      var eid = data.eid;

      if(0 === $('[data-eid="' + eid + '"]').length) {
        self.publish(data);
      }
    });
  };

  // TODO: handle collections (for more efficient updates).
  // TODO: include :type (e.g., 'instagram').
  // TODO: use a (server-shared) template for rendering entries.
  Publisher.prototype.publish = function publish(data) {
    var posts   = this.board.find('ul.corkboard.posts');
    var weights = corkboard.config.weights;
    var random  = new corkboard.WeightedRandomizer(weights);
    var eid     = data.eid;
    var klass   = ['entry', random.sample()].join(' ');
    var entry   = $('<li class="' + klass + '" data-eid="' + data.eid + '" data-tags="' + data.tags + '"><figure><img src="' + data.image + '"><p class="caption">' + data.caption + '</p></figure></li>');

    posts.prepend(entry);

    if(this.callback) {
      this.callback.apply(this, [posts, entry]);
    }
  };

  // // Uncomment to debug Pusher messages.
  // Pusher.log = function(data) {
  //   console.log('\t\t', data);
  // };
})(jQuery, jQuery.corkboard);
