package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class LightsOut extends Sprite 
	{
		private var lights:Array;
		public function LightsOut() 
		{
			super();
			lights = new Array(5);
			trace(lights.length);
			for (var i = 0; i < lights.length; i++) {
				lights[i] = new Light();
				lights[i].x = i * 40;
				lights[i].y = i * 40;
				addChild(lights[i]);
			}
			specialLight.x = 50;
		}
		
	}

}