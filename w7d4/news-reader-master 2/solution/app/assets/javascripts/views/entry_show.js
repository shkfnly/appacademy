NewReader.Views.EntryShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['entries/show'],

  render: function () {
    var content = this.template({
      entry: this.model
    });
    this.$el.html(content);
    return this;
  }
});
