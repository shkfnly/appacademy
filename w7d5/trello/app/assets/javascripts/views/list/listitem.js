TrelloClone.Views.ListItem = Backbone.CompositeView.extend({
  template: JST['list/listitem'],
  orderAttr: 'ord',


  initialize: function(){
    // this.listenTo(this.collection, "sync", this.render);
    this.cardsCollection = new TrelloClone.Collections.Cards()
    this.cardsCollection.add(this.model.get('cards'));
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.cardsCollection, 'add', this.cardHelper);
    this.cardsCollection.each(function(card){
      this.cardHelper(card);
    }.bind(this));
  },

  render: function(){
    var content = this.template({list: this.model});  
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  cardHelper: function(card){
    var view = new TrelloClone.Views.CardItem({model: card});
    this.addSubview('.cards', view);
  },


})