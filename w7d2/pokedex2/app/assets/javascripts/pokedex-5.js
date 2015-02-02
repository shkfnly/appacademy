Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon;
    this.listenTo(this.collection, "change", this.render);
  },

  addPokemonToList: function (pokemon) {
    var content = JST.pokemonListItem({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (callback) {

    var that = this;
    this.collection.fetch({
      success: function(){
        that.render();
        callback && callback();
        },
      failure: function(){console.log("Fail");}
    });
  },

  render: function () {
    this.$el.html("");
    var that = this;
    this.collection.each(function(pokemon){
      that.addPokemonToList(pokemon);
    })
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var pokeId = $target.data('id');
    Backbone.history.navigate(('/pokemon/' + pokeId), {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click li" : "selectToyFromList"
  },

  initialize: function(){
    this.listenTo(this.model, 'change', this.render);
  },

  refreshPokemon: function (callback) {
    var that = this;
    this.model.fetch({
      success: function(){
        that.render();
        callback && callback();
      }
    });
  },

  render: function () {
    var content = JST.pokemonDetail({pokemon: this.model});
    this.$el.html(content);
    var that = this;
    this.model.toys().each(function(toy){
        that.$el.append(JST.toyListItem({toy: toy}));
    });
  },

  selectToyFromList: function (event) {
    var $target = $(event.currentTarget);
    var toyId = $target.data('id');
    Backbone.history.navigate(('/pokemon/' + this.model.id +'/toys/' + toyId), {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var content = JST.toyDetail({toy: this.model, pokes: this.collection});
    this.$el.html(content);
  }
});
