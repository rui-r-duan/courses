function Car() {
    this.speed = 0;
}
Car.prototype = {
    start: function() {
	console.log("Car started.");
    },
    accelerate: function() {
	this.speed = this.speed + 10;
	console.log("Speed is now:" + this.speed + " mph");
    },
    applyBrakes: function() {
	self.speed = 0;
	console.log("Brakes applied.");
    }
};

var c = new Car();
c.start();
c.accelerate();
c.applyBrakes();
