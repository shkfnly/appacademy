Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": 'pokemonIndex',
    "pokemon/:id" : 'pokemonDetail',
    "pokemon/:pokemonId/toys/:toyId" : 'toyDetail'

  },

  pokemonDetail: function (id, callback) {
    $("#pokedex .toy-detail").empty();
    if(this._pokemonIndex){
      var pokemon = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({ model: pokemon });
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this.pokemonForm(pokemon);
      this._pokemonDetail.refreshPokemon(callback);
    }
    else{
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    this.pokemonForm(new Pokedex.Models.Pokemon);


    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
    if(this._pokemonDetail){
      var toy = this._pokemonDetail.model.toys().get(toyId);
      var toyDetailView = new Pokedex.Views.ToyDetail({ model: toy, collection: this._pokemonIndex.collection.models});
      $("#pokedex .toy-detail").html(toyDetailView.$el);
      toyDetailView.render();
    }
    else{
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId))
    }
  },

  pokemonForm: function (model) {
    var formView = new Pokedex.Views.PokemonForm({model: model, collection: this._pokemonIndex.collection});
    formView.render();
    $('.pokemon-form').html(formView.$el);

  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
