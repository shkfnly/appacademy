function _(){

};

_.prototype.each = function(collection, callback){
  if(Array.isArray(collection)){
    for(var i = 0; i < collection.length; i++){
      callback(collection[i], i, collection)
    }
  }
  else{
    for(var key in collection){
      callback(collection[key], key, collection)
    }
  }
}

_.prototype.every = function(collection, test){
  var flag = true
  this.each(collection, function(item){
    if(!test(item)){
      flag = false;
    }
  })
  return flag;
}

_.prototype.some = function(collection, test){
  return !this.every(collection, function(item){
    return !test(item);
  });
}

_.prototype.transpose = function (arr) {
  var columns = [];
  for (var i = 0; i < arr[0].length; i++) {
    columns.push([]);
  }

  for (var i = 0; i < arr.length; i++) {
    for (var j = 0; j < arr[i].length; j++) {
      columns[j].push(arr[i][j]);
    }
  }

  return columns;
};


module.exports = _;
