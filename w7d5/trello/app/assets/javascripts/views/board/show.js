TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST['board/show'],

  initialize: function(){
    this.listCollection = new TrelloClone.Collections.Lists()
    this.listCollection.add(this.model.get('lists'));
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.listCollection, 'add', this.listHelper);
    this.listCollection.each(function(list){
      this.listHelper(list);
    }.bind(this));
  },

  render: function(){
    var content = this.template({board: this.model});
    this.$el.html(content);
    this.attachSubviews();
    this.$("#sortable").sortable();

    return this;
  },

  listHelper: function(list){
    var view = new TrelloClone.Views.ListItem({model: list});
    this.addSubview(".lists", view)
  }
})