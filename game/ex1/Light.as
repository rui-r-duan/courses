package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class Light extends Sprite
	{
		private var isOn:Boolean;
		private var size:int;
		private var ellipseWidth:int = 8;
		private var onColor:uint = 0xFFCC33;
		private var offColor:uint = 0xEEEEEE;
		
		public function Light(sz:int, bOn:Boolean = false)
		{
			super();
			size = sz;
			bOn ? turnOn() : turnOff();
		}
		
		public function getIsOn():Boolean
		{
			return isOn;
		}
		
		public function turnOn():void
		{
			isOn = true;
			graphics.beginFill(onColor);
			graphics.drawRoundRect(0, 0, size, size, ellipseWidth);
			graphics.endFill();
		}
		
		public function turnOff():void
		{
			isOn = false;
			graphics.beginFill(offColor);
			graphics.drawRoundRect(0, 0, size, size, ellipseWidth);
			graphics.endFill();
		}
	
		public function invertState():void
		{
			isOn = !isOn;
			var color:uint = isOn ? onColor : offColor;
			graphics.beginFill(color);
			graphics.drawRoundRect(0, 0, size, size, ellipseWidth);
			graphics.endFill();
		}
	}

}