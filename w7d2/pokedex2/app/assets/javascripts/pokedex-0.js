window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: '/pokemon',

  // Phase II
  parse: function (payload) {
    if (payload.toys) {
      this.toys().set(payload.toys);
      delete payload.toys;

      // Phase IV
      this.toys().forEach((function (toy) {
        toy._pokemon = this;
      }).bind(this));
    }

    return payload;
  },

  // Phase II
  toys: function () {
    if (!this._toys) {
      this._toys =
        new Pokedex.Collections.PokemonToys([], { pokemon: this });
    }

    return this._toys;
  }
});

Pokedex.Models.Toy = Backbone.Model.extend({
  urlRoot: '/toys',

  // Phase IV
  pokemon: function () {
    if (!this._pokemon) {
      this._pokemon =
        new Pokedex.Models.Pokemon({ id: this.pokemon_id });
    }

    return this._pokemon;
  },

  // Phase IV
  parse: function (payload) {
    if (payload.pokemon) {
      this._pokemon =
        new Pokedex.Models.Pokemon(payload.pokemon, { parse: true });
      delete payload.pokemon;
    }

    return payload;
  }
});

Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  model: Pokedex.Models.Pokemon,
  url: '/pokemon'
});

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({
  model: Pokedex.Models.Toy,

  initialize: function(models, options) {
    this.pokemon = options.pokemon;
  }
});

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  // Click handlers go here.
  this.$pokeList.on(
    'click', 'li', this.selectPokemonFromList.bind(this)
  );
  this.$newPoke.on(
    'submit', this.submitPokemonForm.bind(this)
  );
  this.$pokeDetail.on(
    'click', '.toys li', this.selectToyFromList.bind(this)
  );
  this.$toyDetail.on(
    'change', 'select', this.reassignToy.bind(this)
  );
};
// 
// $(function() {
//   var $rootEl = $('#pokedex');
//   window.Pokedex.rootView = new Pokedex.RootView($rootEl);
//   window.Pokedex.rootView.refreshPokemon();
// });
