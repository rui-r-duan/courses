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
		
		public function Light()
		{
			super();
			turnOff();
			addEventListener(MouseEvent.CLICK, onClicked);
			trace("Create Light");
		}
		
		public function turnOn():void
		{
			isOn = true;
			graphics.beginFill(0xFFCC33);
			graphics.drawRoundRect(0, 0, 40, 40, 4);
			graphics.endFill();
		}
		
		public function turnOff():void
		{
			isOn = false;
			graphics.beginFill(0xEEEEEE);
			graphics.drawRoundRect(0, 0, 40, 40, 4);
			graphics.endFill();
		}
		
		private function onClicked(evt:MouseEvent)
		{
			if (isOn)
			{
				turnOff();
			}
			else
			{
				turnOn();
			}
		}
	
	}

}