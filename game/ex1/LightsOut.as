package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class LightsOut extends Sprite
	{
		private var lights:Array;
		private var numLightsRow:int = 5;
		private var numLightsCol:int = 5;
		private var spacing:int = 10;
		
		public function LightsOut()
		{
			super();
			lights = new Array(numLightsRow);
			for (var i:int = 0; i < numLightsRow; i++)
			{
				lights[i] = new Array(numLightsCol);
				for (var j:int = 0; j < numLightsCol; j++)
				{
					lights[i][j] = new Light();
					lights[i][j].x = (j + 1) * spacing + j * lights[i][j].width;
					lights[i][j].y = (i + 1) * spacing + i * lights[i][j].height;
					addChild(lights[i][j]);
				}
			}
			lights[3][2].turnOn();
			lights[4][1].turnOn();
		}

	}

}