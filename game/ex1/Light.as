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
		private const ellipseWidth:int = 8;
		private const onColor:uint = 0xFFCC33;
		private const offColor:uint = 0xEEEEEE;

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
			redraw();
		}

		public function turnOff():void
		{
			isOn = false;
			redraw();
		}

		public function invertState():void
		{
			isOn = !isOn;
			redraw();
		}

		private function redraw():void
		{
			var color:uint = isOn ? onColor : offColor;
			graphics.beginFill(color);
			graphics.drawRoundRect(0, 0, size, size, ellipseWidth);
			graphics.endFill();
		}
	}
}