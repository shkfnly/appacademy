Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);

  pokemon.save(attrs, {
    success: (function() {
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback && callback.call(this, pokemon);
    }).bind(this)
  });

  return pokemon;
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var pokeAttrs = ($(event.target).serializeJSON())['pokemon'];

  this.createPokemon(pokeAttrs, this.renderPokemonDetail.bind(this));
};
