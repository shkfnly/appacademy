TrelloClone.Views.ListItem = Backbone.CompositeView.extend({
  template: JST['list/listitem'],
  className: 'col-md-3 list',
  orderAttr: 'ord',

  events: {
    'submit': 'newCard',
    'drop'  : 'listSortStart'
  },


  initialize: function(){
    // this.listenTo(this.collection, "sync", this.render);
    this.cardsCollection = this.model.cards()
    this.listenTo(this.cardsCollection, 'sync', this.render);
    this.listenTo(this.cardsCollection, 'add', this.cardHelper);
    this.cardsCollection.each(function(card){
      this.cardHelper(card);
    }.bind(this));
    this.formHelper();
  },

  render: function(){
    var content = this.template({list: this.model});  
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  cardHelper: function(card){
    var view = new TrelloClone.Views.CardItem({model: card, collection: this.cardsCollection});
    this.addSubview('.cards', view);
  },
  formHelper: function(){
    var view = new TrelloClone.Views.CardForm({model: this.model, collection: this.cardsCollection});
    this.addSubview('.card-form', view)
  },
   listSortStart: function(event, index){
    this.$el.trigger('update-sort', [this.model, index, this]);
  },

})