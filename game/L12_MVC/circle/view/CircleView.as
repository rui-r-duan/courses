package circle.view {
	import circle.*;
	import circle.model.*;
	import circle.view.*;
	import circle.controller.*;
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class CircleView {
		var model:CircleModel;
		var controller:CircleController;
		var circleInst:MovieClip;
		
		public function CircleView(model:CircleModel, controller:CircleController,
		holder:MovieClip, positionX:Number, positionY:Number, width:Number) {
			trace("CircleView:CircleView()");
			// setup mvc references
			this.model = model;
			this.controller = controller;
			// create circle
			this.circleInst = create(holder, positionX, positionY, width);
		}
		
		function create(holder:MovieClip, positionX:Number, positionY:Number, width:Number):MovieClip {
			trace("CircleView:create()");
			// create movieclip
			var c = new MovieClip;
			holder.addChild(c);
			// draw circle on screen
			c.graphics.lineStyle(1);
			c.graphics.beginFill(0x000000);
			c.graphics.drawCircle(positionX, positionY, width / 2);
			c.graphics.endFill();
			// create button
			var h = new MovieClip;
			holder.addChild(h);
			var b:Button = new Button;
			h.addChild(b);
			b.label = "Recolour";
			b.x = 15;
			b.y = 15;
			// attach click event
			b.addEventListener(MouseEvent.CLICK, controller.click);
			// return circle
			return c;
		}
		
		public function update(e:Event):void {
			trace("CircleView:update(" + colour + ")");
			
			// get updated colour from the model
			var colour = model.getColour();
			
			// create colour object for circle
			var circleColour:ColorTransform = circleInst.transform.colorTransform;
			circleColour.color = colour;
			circleInst.transform.colorTransform = circleColour;
		}
	}
}