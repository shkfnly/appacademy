// var readline = require('readline');
// var reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });
//
//
// var addNumbers = function(sum, numsLeft, completionCallback){
//
//   if(numsLeft > 0){
//     reader.question("Enter a number:", function(numString){
//       number = parseInt(numString);
//       sum += number;
//       console.log(sum);
//       numsLeft--;
//       addNumbers(sum, numsLeft, completionCallback);
//     })
//   }
//   else{
//     completionCallback(sum);
//     reader.close();
//   }
// }
//
// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var askIfLessThan = function(el1, el2, callback) {
  reader.question("is " + el1 + " <= " + el2 + "?", function(answerString){
    if(answerString === "yes"){
      var answer = true;
    } else {
      var answer = false;
    }
    callback(answer)
  })

}

var innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if(i < arr.length - 1){
    askIfLessThan(arr[i], arr[i + 1], function(isLessThan){
      if(!isLessThan){
        var temp = arr[i]
        arr[i] = arr[i + 1]
        arr[i + 1] = temp
        madeAnySwaps = true
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop)
    })
  }
  else if(i === (arr.length - 1)){
    outerBubbleSortLoop(madeAnySwaps);
  }
}



var absurdBubbleSort = function(arr, sortCompletionCallback){
  var outerBubbleSortLoop= function(boolean){
    if(boolean){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else{
      sortCompletionCallback(arr);
      reader.close();
    }
  }
  outerBubbleSortLoop(true);

}

// absurdBubbleSort([5,3,5,2,1], function(arr){
//   arr.forEach(function(item){
//     console.log(item);
//   })
// })


Function.prototype.myBind = function(context){
  var fn = this
  return function(){
    return fn.apply(context);
  }
}

var module = {
  test: "I'm a test"
}


var func_to_call = function(){
  console.log(this.test)
  console.log("Yay i'm the right function")
}

test = "I'm the global test"

var boundFunction = func_to_call.myBind(module)
boundFunction()
func_to_call()
