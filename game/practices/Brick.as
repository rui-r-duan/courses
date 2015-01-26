package  {
	
	import flash.display.MovieClip;
	
	
	public class Brick extends MovieClip {
		
		public var color: String = "red";
		public function Brick() {
			// constructor code
			trace("new " + color + " brick created");
		}
	}
	
}
