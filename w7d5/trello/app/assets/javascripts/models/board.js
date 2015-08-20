TrelloClone.Models.Board = Backbone.Model.extend({
  urlRoot: 'api/boards',

  lists: function(){
    if(!this._lists){
      this._lists = new TrelloClone.Collections.Lists();
    }
    return this._lists;
  },

  parse: function(payload){

    if (payload.lists) {
      this.lists().set(payload.lists, {parse: true});
      delete payload.lists;
    }
    return payload;
  }
})