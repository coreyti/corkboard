describe("corkboard.js", function() {
  describe("$.corkboard.version", function() {
    it("is defined", function() {
      expect($.corkboard.version).toEqual('0.1.0');
    });
  });

  describe("$.corkboard.config", function() {
    var config = $.corkboard.config;

    it("specifies a key for the Pusher service", function() {
      expect(config.pusher).toBeDefined();
    });

    it("specifies the display 'weights' for tiles", function() {
      expect(config.weights).toEqual({
        s : 10,
        m : 3,
        l : 1
      });
    });
  });

  describe("$.fn.corkboard", function() {
    before(function() {
      spyOn($.corkboard, 'Board');
    });

    it("is defined", function() {
      expect($.fn.corkboard).toBeDefined();
    });

    it("creates a new Board", function() {
      var object = $('<div>');
      var result = object.corkboard();
      expect($.corkboard.Board).toHaveBeenCalled();
    });

    it("returns the given jQuery object", function() {
      var object = $('<div>');
      var result = object.corkboard();
      expect(result).toEqual(object);
    });
  });
});
