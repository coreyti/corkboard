(function($, g) {
  $.extend(g, {
    context : function(description, definitions) {
      return jasmine.getEnv().describe(description, definitions);
    },

    fixture : function(path, load) {
      function readonly() {
        return readFixtures(path);
      }

      function rendered() {
        loadFixtures(path);
        return $('#jasmine-fixtures').children();
      }

      return (load ? rendered() : readonly());
    },

    before : function(callback) {
      return jasmine.getEnv().beforeEach(callback);
    },

    after : function(callback) {
      return jasmine.getEnv().afterEach(callback);
    },

    undefine : function(object, property) {
      var original = object[property];
      object[property] = undefined;

      jasmine.getEnv().currentSpec.after(function() {
        object[property] = original;
      });
    }
  });

  function parseKey(content) {
    return /define\(["']([a-z:_-]+)["']/.exec(content)[1];
  }
})(jQuery, this);
