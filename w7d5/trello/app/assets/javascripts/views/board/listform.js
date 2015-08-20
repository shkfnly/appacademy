TrelloClone.Views.ListForm = Backbone.View.extend({
  template: JST['list/form'],

  events: {
    "submit": "createList"
  },

  tagName: "form",

  initialize: function(options){
    this.board = options.board;
  },
  render: function(){
    var content = this.template({list: this.model});
    this.$el.html(content);
    return this;
  },

  createList: function(event){
    debugger
    event.preventDefault();
    var data = $(event.target).serializeJSON();
    data.list.board_id = this.board.id
    this.model.save(data, {
      success: function(){
        this.collection.add(this.model);
      }.bind(this)
    })
  },
})