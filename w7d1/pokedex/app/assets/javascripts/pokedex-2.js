Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li data-pokemon-id='" + toy.get("pokemon_id") + "' data-toy-id='" + toy.get("id") + "'>" + toy.get("name") + " " + toy.get("happiness") + " " + toy.get("price") + "</li>");
  var $ul = this.$pokeDetail.find('ul.toys');
  $ul.append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.html('');
  var $div = $("<div class='detail'>");
  var $img = $("<img src='" +  toy.get("image_url") + "'>");
  $div.append($img);
  $div.append("<ul class='toy-deets'></ul>");
  _.each(toy.attributes, function(attrib, attribName){
    $div.find('.toy-deets').append('<li>' + attribName + ' : ' + attrib + "</li>")
  })
  $div.append("<select class='poke-select' data-pokemon-id='" + toy.get("pokemon_id") + "' data-toy-id='" + toy.get("id") + "'></select>")
    this.pokes.each( function(item){
      if(item.get('id') === toy.get('pokemon_id')){
        $div.find('.poke-select').append("<option value='" + item.get('id') + "' selected>" + item.get('name') + "</option>");
      }
      else{
        $div.find('.poke-select').append("<option value='" + item.get('id') + "'>" + item.get('name') + "</option>");
      }
    })

  this.$toyDetail.append($div);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  event.preventDefault();
  var toyId = $(event.target).data("toy-id");
  var pokemonId = $(event.target).data("pokemon-id");
  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);

  this.renderToyDetail(toy);

};
