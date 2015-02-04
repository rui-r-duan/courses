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
		private var moveCnt:int;
		private const numLightsRow:int = 5;
		private const numLightsCol:int = 5;
		private const spacing:int = 14;
		private const lightSize:int = 50;
		private const marginTop:int = (stage.stageHeight
			- lightSize * numLightsRow - spacing * (numLightsRow - 1)) / 2;
		private const marginLeft:int = lightSize;
		
		public function LightsOut()
		{
			super();
			lights = new Array(numLightsRow);
			moveCnt = 0;
			for (var i:int = 0; i < numLightsRow; i++)
			{
				lights[i] = new Array(numLightsCol);
				for (var j:int = 0; j < numLightsCol; j++)
				{
					lights[i][j] = new Light(lightSize);
					lights[i][j].x = marginLeft + j * spacing
						+ j * lights[i][j].width;
					lights[i][j].y = marginTop + i * spacing
						+ i * lights[i][j].height;
					addChild(lights[i][j]);
					lights[i][j].addEventListener(MouseEvent.CLICK,
						createListener(i, j));
				}
			}
			lights[3][0].turnOn();
			lights[4][0].turnOn();
			lights[4][1].turnOn();
		}
		
		private function createListener(a:int, b:int):Function
		{
			// Use a closure to capture index (a,b) outside of the Light that
			// is bounded to this listener.
			var foo:Function = function(evt:MouseEvent):void
			{
				moveCnt++;
				trace(moveCnt);
				switchAt(a, b);
				if (isWin())
				{
					trace("You Win!");
				}
			}
			return foo;
		}
		
		private function switchAt(row:int, col:int):void
		{
			lights[row][col].invertState();
			if (row > 0)
			{
				lights[row - 1][col].invertState();
			}
			if (row < numLightsRow - 1)
			{
				lights[row + 1][col].invertState();
			}
			if (col > 0)
			{
				lights[row][col - 1].invertState();
			}
			if (col < numLightsCol - 1)
			{
				lights[row][col + 1].invertState();
			}
		}
		
		private function isWin():Boolean
		{
			var isDone:Boolean = true;
			for (var i:int = 0; i < numLightsRow; i++)
			{
				for (var j:int = 0; j < numLightsCol; j++)
				{
					isDone = isDone && !lights[i][j].getIsOn();
				}
			}
			return isDone;
		}
	}
}