NewsReader.Collections.Entries = Backbone.Collection.extend({
  url: function(){
    return this.feed.url() + '/entries'},
  model: NewsReader.Models.Entry,

  comparator: function(model1, model2){
    var oneDate = model1.get("published_at");
    var twoDate = model2.get("published_at");
    if (oneDate === twoDate) {
      return 0;
    } else if (oneDate < twoDate) {
      return 1;
    } else {
      return -1;
    }
  },

  initialize: function(arr, options){
    this.feed = options.feed;

  }

})
