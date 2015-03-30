package circle.model {

	import circle.*;
	import circle.model.*;
	import circle.view.*;
	import circle.controller.*;
	import flash.events.EventDispatcher;
	import falsh.events.Event;
	
	public class CircleModel extends EventDispatcher {
		public static const UPDATE:String = 'update';
		var colour:Number;
		
		public function CircleModel() {
			trace("CircleModel:CircleModel()");
		}
		
		public function setColour(colour:Number):void {
			trace("CircleModel:setColour()");
			// set colour in model
			this.colour = colour;
			// notify observers of change
			notifyObservers();
		}
		
		public function getColour():Number {
			return colour;
		}
		
		function notifyObservers():void {
			trace("CircleModel:notifyObservers()");
			// broadcastMessage
			dispatchEvent(new flash.events.Event(circleModel.UPDATE));
		}
	}
}