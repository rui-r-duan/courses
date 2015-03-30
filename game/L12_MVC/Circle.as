package {
	import circle.model.*;
	import circle.view.*;
	import circle.controller.*;
	import flash.display.MovieClip;
	
	public class Circle extends MovieClip {
		private var circle_model:CircleModel;
		private var circle_view:CircleView;
		private var circle_controller:CircleController;
		
		public function Circle(holder:MovieClip, positionX:Number, positionY:Number, width:Number) {
			trace("Circle:Circle()");
			
			// create the data model
			circle_model = new CircleModel();
			
			// create the controller
			circle_controller = new CircleController(circle_model);
			
			// create the view
			circle_view = new CircleView(circle_model, circle_controller, holder, positionX, positionY, width);
			
			// add circle_view as a listener to the circle_model
			circle_model.addEventListener(CircleModel.UPDATE, circle_view.update);
			
			// set default color
			circle_model.setColour(Math.round(Math.random() * 0xFFFFFF));
		}
	}
	
}