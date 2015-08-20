Pokedex.RootView.prototype.reassignToy = function (event) {
  var $currentTarget = $(event.currentTarget);

  var pokemon = this.pokes.get($currentTarget.data("pokemon-id"));
  var toy = pokemon.toys().get($currentTarget.data("toy-id"));

  toy.set("pokemon_id", $currentTarget.val());
  toy.save({}, {
    success: (function () {
      pokemon.toys().remove(toy);
      this.renderToysList(pokemon.toys());
      this.$toyDetail.empty();
    }).bind(this)
  });
};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  toys.each((function(toy) {
    this.addToyToList(toy);
  }).bind(this));
};
