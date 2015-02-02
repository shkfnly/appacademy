Journal.Views.PostShow = Backbone.View.extend({
  template: JST['posts/postshow'],

  events: {
    'click .back-button' : 'back'
  },

  render: function(){

    this.model.fetch({
      success: function(){
        var itemContent = this.template({ item: this.model });
        this.$el.html(itemContent);
      }.bind(this)
    })
    return this;
  },

  back: function(event) {
    event.preventDefault();
    Backbone.history.navigate(
      "", {trigger: true}
    );
  }
})
