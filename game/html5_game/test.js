function Car() {
    // The object that the this keyword points to can change based on where it
    // is called from.  Using a local self variable gives us assurance that the
    // calls within the object will function properly.
    var self = this;
    self.speed = 0;
    self.start = function() {
	console.log("Car started.");
    };
    self.accelerate = function() {
	this.speed = this.speed + 10;
	console.log("Speed is now:" + this.speed + " mph");
    };
    self.applyBrakes = function() {
	self.speed = 0;
	console.log("Brakes applied.");
    };
}

var c = new Car();
c.start();
c.accelerate();
c.applyBrakes();
