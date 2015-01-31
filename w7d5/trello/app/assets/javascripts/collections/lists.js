TrelloClone.Collections.Lists = Backbone.Collection.extend({
  url: 'api/lists',
  model: TrelloClone.Models.List,

  getOrFetch: function(id) {
    var list = this.get(id);
    if (!list) {
      list = new TrelloClone.Models.List({id: id})
      list.fetch({
        success: function(){
          this.add(list);
        }.bind(this)
      });
    }
    else{
      list.fetch();
    }
    return list;
  },
})