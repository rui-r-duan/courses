function clickCounter() {
    console.log(typeof(Storage)); // function
    console.log(typeof(window.Storage)); // function
    if (typeof(Storage) !== "undefined") {
	// localStorage.removeItem("clickcount");
	if (localStorage.clickcount) {
	    localStorage.clickcount = Number(localStorage.clickcount) + 1;
	} else {
	    localStorage.clickcount = 1;
	}
	document.getElementById("result").innerHTML = "You have clicked the button "
	+ localStorage.clickcount + " time(s).";
    } else {
	document.getElementById("result").innerHTML = "No Web storage support";
    }
}
