$.Tabs = function (el) {
    this.$el = $(el);
    this.$contentTabs = $(this.$el.data("contentTabs"))
    this.$activeTab = $(this.$contentTabs.find('.active'));

    this.$el.on("click", "a", this.clickTab.bind(this));
  };

$.Tabs.prototype.clickTab = function(event){
  event.preventDefault();

  this.$el.find("a").removeClass('active');
  var activeLink = $(event.currentTarget);
  activeLink.addClass('active')
 
  var newActiveSel = $(event.currentTarget).attr("href");
  var $newActiveTab = this.$contentTabs.find(newActiveSel);

  this.$activeTab.removeClass('active').addClass('transitioning');
  this.$activeTab.one("transitioned", (function(){
    this.$activeTab.removeClass('transitioning');

    this.$activeTab = $newActiveTab;
    this.$activeTab.addClass("transitioning");
    setTimeout((function(){
      
      that.$activeTab.removeClass("transitioning").addClass("active");
    }).bind(this), 0);
  }).bind(this));
};

//I'm curious how this work, needs further explaination
$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
