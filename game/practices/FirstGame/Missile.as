package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class Missile extends Sprite 
	{
		
		public function Missile() 
		{
			super();
			// Setup an event listener to see if our missile is added to the stage
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			// Now that our object is on the stage, run our custom code
			init();
		}
		
		private function init():void 
		{
			addEventListener(Event.ENTER_FRAME, missileLoop);
		}
		
		private function missileLoop(e:Event):void 
		{
			this.y -= 10;
		}
		
		public function destroyMissile():void
		{
			// Remove the object from the stage
			parent.removeChild(this);
			// Remove any event listeners
			removeEventListener(Event.ENTER_FRAME, missileLoop);
		}
	}

}