describe("corkboard/base.js", function() {
  it("defines $.corkboard", function() {
    expect($.corkboard).toBeDefined();
  });

  describe("$.corkboard.defaults", function() {
    var defaults = $.corkboard.defaults;

    it("is defined", function() {
      expect(defaults).toBeDefined();
    });

    it("specifies a value for 'fade', used by visibility transitions", function() {
      expect(defaults.fade).toEqual('slow');
    });
  });
});
