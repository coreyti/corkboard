(function($, corkboard) {
  // Ported to JS from weighted_randomizer Ruby gem.
  function WeightedRandomizer(setup) {
    this.normalize(setup);
  }

  // Surfaced as part of the corkboard namespace.
  corkboard.WeightedRandomizer = WeightedRandomizer;

  WeightedRandomizer.prototype.normalize = function normalize(setup) {
    var dict = {};
    var sum  = 0.0;

    $.each(setup, function(key, weight) {
      sum += weight;
    });

    $.each(setup, function(key, weight) {
      dict[key] = (weight / sum);
    });

    this.normalized = dict;
  };

  WeightedRandomizer.prototype.sample = function sample() {
    var pick = Math.random();
    var result;

    $.each(this.normalized, function(key, weight) {
      result = key;

      if(pick <= weight) {
        return false;
      }

      pick -= weight;
    });

    return result;
  };
})(jQuery, jQuery.corkboard);
