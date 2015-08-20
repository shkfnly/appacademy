TrelloClone.Views.CardForm = Backbone.View.extend({
  template: JST['card/form'],
  tagName: 'form',
  className: 'cardForm',

  events: {
    "submit": "newCard"
  },

  initialize: function(options){
    this.list = options.list;
  },

  render: function(){
    var content = this.template({list: this.model});
    this.$el.html(content);
    return this;

  },

  newCard: function(event){
    event.preventDefault();
    var data = $(event.target).serializeJSON();
    data.card.list_id = this.model.id;
    var model = new TrelloClone.Models.Card();
    model.save(data, {
      success: function(){
        this.collection.add(model);
      }.bind(this)
    })
  },
})