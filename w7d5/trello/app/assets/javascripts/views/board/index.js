TrelloClone.Views.BoardIndex = Backbone.CompositeView.extend({
  template: JST['board/index'],
  
  initialize: function(){
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, 'add', this.itemHelper);
    this.collection.each(function(board){
      this.itemHelper(board)
    }.bind(this));
    
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    
    return this;
  },

  itemHelper: function(board){
    var view = new TrelloClone.Views.BoardIndexItem({model: board})
    this.addSubview(".boards", view);
  }
})