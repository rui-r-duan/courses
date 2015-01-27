package {

	import flash.display.MovieClip;
	import flash.events.Event;

	public class MBall extends MovieClip {

		var dy: Number = 10;
		var dx: Number = 10;
		public function MBall() {
			addEventListener(Event.ENTER_FRAME, ballmovement, false, 0, true);
			x = 100;
			y = 100;
		}
		function ballmovement(e: Event): void {
			y += dy;

			x += dx;

			if (y < 0) {
				//dy *= -1;
				dy = 10
			}
			if (y > stage.stageHeight) {
				//dy *= -1;
				dy = -10;
			}
			if (x < 0) {
				//dx *= -2;
				dx = 10
			}
			if (x > stage.stageWidth) {
				//dx *= -2;
				dx = -10;
			}
			
			// colission test
			if (this.hitTestObject(bat1)) {
				trace("Hit Bat 1");
			}
			if (this.hitTestObject(bat2)) {
				trace("Hit Bat 2");
			}
		}
	}
}