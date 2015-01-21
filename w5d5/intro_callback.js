function absurdTimes (numTimes, fn, completionFn) {
  var i = 0;

  function loopStep() {
    if (i == numTimes) {
      // we're done, stop looping
      completionFn();
      return;
    }

    i += 1;

    fn(loopStep);
  }

  loopStep();
}

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addTwoNumbers (callback) {
  reader.question("Enter #1", function (numString1) {
    reader.question("Enter #2", function (numString2) {
      var num1 = parseInt(numString1);
      var num2 = parseInt(numString2);

      callback(num1 + num2);
    });
  });
}

var totalSum = 0;
absurdTimes(3, function (callback) {
  addTwoNumbers(function (result) {
    totalSum += result;

    console.log("sum: " + result);
    console.log("totalSum: " + totalSum);

    callback();
  });
}, function () {
  console.log("All done! totalSum: " + totalSum);
  reader.close();
});
