var interval;

function checkFor12M() {
    var now = new Date();
    if ((now.getHours() == 0) && (now.getMinutes() == 0)) {
	console.log("It is now 12 midnight.");
	// Clearing timeout
	clearInterval(interval);
    } else {
	console.log("It is not 12 midnight.");
    }
}

interval = setInterval(checkFor12M, 5000);
