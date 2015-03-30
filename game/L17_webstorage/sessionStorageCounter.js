function clickCounter() {
    if (typeof(Storage) !== "undefined") { // Storage is a function
	if (sessionStorage.clickcount) { // referesh the page does not remove it
	    sessionStorage.clickcount = Number(sessionStorage.clickcount) + 1;
	} else {
	    sessionStorage.clickcount = 1;
	}
	document.getElementById("result").innerHTML = "You have clicked the button "
	+ sessionStorage.clickcount + " time(s).";
    } else {
	document.getElementById("result").innerHTML = "No Web storage support";
    }
}
