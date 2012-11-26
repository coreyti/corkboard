describe("corkboard/lib/weighted_randomizer.js", function() {
  it("defines $.corkboard.WeightedRandomizer", function() {
    expect($.corkboard.WeightedRandomizer).toBeDefined();
  });

  describe("WeightedRandomizer", function() {
    var constructor = $.corkboard.WeightedRandomizer;

    describe("constructor", function() {
      it("normalizes the setup data", function() {
        var instance = new constructor({ one : 2, two : 8 });
        expect(instance.normalized).toEqual({ one : 0.2, two : 0.8 });
      });
    });

    describe("#sample", function() {
      it("returns a selection from the setup, weighted by value", function() {
        var instance = new constructor({ one : 0, two : 1000000 });
        expect(instance.sample()).toEqual('two');
      });
    });
  });
});
