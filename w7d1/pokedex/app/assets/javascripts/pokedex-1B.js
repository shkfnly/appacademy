Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  pokemon.fetch({
    success: function(){
      _.each(pokemon.toys().models, function(toy){
        this.addToyToList(toy);
      }.bind(this))
    }.bind(this)
  })
  this.$pokeDetail.html('')
  var $div = $("<div class='detail'>")
  var $img = $("<img src='" +  pokemon.get("image_url") + "'>")
  $div.append($img);
  $div.append("<ul class='poke-deets'>");
  $div.append("<ul class='toys'>");

  _.each(pokemon.attributes, function(attrib, attribName){
    $div.find('.poke-deets').append('<li>' + attribName + ' : ' + attrib)
  })
  this.$pokeDetail.append($div)
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data("id");

  var pokemon = this.pokes.get(id);
  pokemon.fetch({
    success: this.renderPokemonDetail.bind(this, pokemon)
  });
};
