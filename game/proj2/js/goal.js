function Goal(img) {
    var self = this;
    self.img = img;
    self.x = 0;
    self.y = 0;
}

Goal.prototype = {
    isPointInGoal: function(pt) {
	return pt.x > this.x && pt.x < this.x + this.img.width
	    && pt.y > this.y && pt.y < this.y + this.img.height;
    }
};
