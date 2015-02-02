Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form" : 'savePokemon',
    "keyup input" : 'savePokemon',
    "change select" : 'savePokemon'
  },


  render: function () {
    var content = JST.pokemonForm({pokemon: this.model});
    this.$el.html(content);
  },

  savePokemon: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();
    var that = this;
    this.model.set(data.pokemon)
    if(this.model.isValid()){
      this.model.save({}, {
        success: function(){
          that.collection.add(that.model);

          Backbone.history.navigate(('pokemon/' + that.model.id), {trigger: true});
        }
      });
    }
  }
});
