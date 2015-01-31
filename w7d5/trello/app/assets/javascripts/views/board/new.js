TrelloClone.Views.BoardNew = Backbone.View.extend({
  template: JST['board/form'],
  tagName: 'form',
  events: {
    'submit' : 'formSubmit'
  },

  render: function(){
    var content = this.template({board: this.model})
    this.$el.html(content)
    return this;
  },

  formSubmit: function(event){
    event.preventDefault();
    var data = $(event.target).serializeJSON();
    this.model.save(data, {
      success: function(){
        this.collection.add(this.model);
        Backbone.history.navigate('', {trigger: true})
      }.bind(this)
    })
  }
})