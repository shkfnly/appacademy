Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon();
  pokemon.save(attrs, {
    success: function(){
      this.pokes.add(pokemon);
      this.addPokemonToList(pokemon);
      callback(pokemon);
    }.bind(this),
    failure: function(){
    }
  }
  );


};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var data = $(event.target).serializeJSON();
  this.createPokemon(data, this.renderPokemonDetail.bind(this));
};
