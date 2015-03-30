package circle.controller {
	import circle.*;
	import circle.model.*;
	import circle.view.*;
	import circle.controller.*;
	import flash.events.MouseEvent;
	
	public class CircleController {
		var model:CircleModel;
		
		public function CircleController(model:CircleModel) {
			trace("CircleController:CircleController()");
			
			// attach model
			this.model = model;
		}
		
		public function click(e:MouseEvent):void {
			trace("CircleController:click()");
			
			// create random colour
			var randomColour = Math.round(Math.random() * 0xFFFFFF);
			
			// set random colour in the model
			model.setColour(randomColour);
		}
	}
}