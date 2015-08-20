TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  template: JST['board/indexitem'],
  tagName: 'li',

  initialize: function (options) {
    this.open = false;
    this.listenTo(this.model, "change", this.render)
  },

  events: {
    // 'click' : 'itemClick'
  },

  render: function(){
    
    var content = this.template({board: this.model});
    this.$el.html(content);
    return this;
  },

  itemClick: function(event){
    Backbone.history.navigate('/boards/' + this.model.id, {trigger: true})
  }
})