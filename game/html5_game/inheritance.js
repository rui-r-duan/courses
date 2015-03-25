function Car() {
    var self = this;
    self.type = "Car";
    self.go = function() {
	console.log("Going...");
    };
};
Toyota = function() {};		// warning: undeclared variable or function
Toyota.prototype = new Car();
Toyota.prototype.constructor = function() {
    var self = this;
    self.type = "Toyota";
    self.go = function() {
	console.log("A Toyota car is going...");
    };
};
Toyota.prototype.isJapaneseCar = true;
var t = new Toyota();
console.log(t instanceof Toyota);
console.log(t instanceof Car);
