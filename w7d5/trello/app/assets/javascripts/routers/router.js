TrelloClone.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = $(options.$rootEl);
    this.collection = new TrelloClone.Collections.Boards();
  },

  routes : {
    "" : "index",
    "boards/new": "newBoard",
    "boards/:id": "show",
    
  },

  index: function(){
    var indexView = new TrelloClone.Views.BoardIndex({collection: this.collection});
    indexView.collection.fetch({
      success: function(){
        this.$rootEl.html(indexView.render().$el)
      }.bind(this)
    });
  },

  show: function(id){
    var model = this.collection.getOrFetch(id)
    model.fetch({
      success: function(){
        var showView = new TrelloClone.Views.BoardShow({model: model})
        this._swapView(showView);
        // this.$rootEl.html(showView.render().$el)
      }.bind(this)
    })
  },

  newBoard: function(){
    var model = new TrelloClone.Models.Board()
    var view = new TrelloClone.Views.BoardNew({model: model, collection: this.collection});
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currrentView && this._currrentView.remove();
    this._currrentView = newView;
    this.$rootEl.html(newView.render().$el);
  },
})