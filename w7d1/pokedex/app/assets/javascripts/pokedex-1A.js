Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  $(this.$pokeList).append("<li class='poke-list-item' data-id='" +pokemon.id +"'>" + pokemon.get("name") + " : "
    + pokemon.get("poke_type"))
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.pokes.fetch({
    success: function() {
      this.pokes.each(function(pokemon) {
        this.addPokemonToList(pokemon);
      }.bind(this));
    }.bind(this)
  });
};
