TrelloClone.Views.CardItem = Backbone.CompositeView.extend({
  template: JST['card/item'],
  tagName: 'li',
  className: 'ui-state-default card',


  render: function(){
    var content = this.template({card: this.model});
    this.$el.html(content);
    return this;
  }
})