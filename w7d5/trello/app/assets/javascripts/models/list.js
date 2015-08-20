TrelloClone.Models.List = Backbone.Model.extend({
  urlRoot: 'api/lists',
  cards: function(){
    if(!this._cards){
      this._cards = new TrelloClone.Collections.Cards();
    }
    return this._cards;
  },

  parse: function(payload){
    if (payload.cards){
      this.cards().set(payload.cards, {parse: true})
      delete payload.cards;
    }
    return payload
  }
})