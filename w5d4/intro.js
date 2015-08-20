var uniq = function(arr){
  uniqarr = [];
  var uniqueness = function(item){
    if(uniqarr.indexOf(item) === -1){
      uniqarr.push(item);
    }
  }
  arr.forEach(uniqueness);
  return uniqarr;

}

var twoSum = function(arr){
  var solution = [];
  for(var i = 0; i < arr.length - 1; i++){
    for(var j = i + 1; j < arr.length; j++){
      if((arr[i] + arr[j]) === 0 ){
        solution.push([i , j]);
      }
    }
  }
  return solution;
}
