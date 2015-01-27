package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class FirstGame extends MovieClip 
	{
		public var mcPlayer:MovieClip;

		private var leftKeyIsDown:Boolean;
		private var rightKeyIsDown:Boolean;
		
		private var aMissileArray:Array;

		public function FirstGame() 
		{
			super();
			
			// Initialize variables
			aMissileArray = new Array();
			
			// Setup listeners to listen for when a key is pressed and released
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			// Setup a game loop event listener
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		private function gameLoop(e:Event):void 
		{
			playerControl();
			clampPlayerToStage();
			checkMissileOffScreen();
		}
		
		private function checkMissileOffScreen():void 
		{
			// Loop through all our missiles in our mnissile array
			for (var i:int = 0; i < aMissileArray.length; i++)
			{
				// Get the current missile in the loop
				var currentMissile:Missile = aMissileArray[i];
				// Test if our current missile is past the top of the screen
				if (currentMissile.y < 0)
				{
					// Remove the current missile from the array
					aMissileArray.splice(i, 1);
					// Destroy our missile
					currentMissile.destroyMissile();
				}
			}
		}
		
		private function clampPlayerToStage():void 
		{
			// If our player is to the left of the stage
			if (mcPlayer.x < 0 + mcPlayer.width / 2)
			{
				// Set our player to the left of the stage
				mcPlayer.x = mcPlayer.width / 2;
			}
			// If our player is to the right of the stage
			if (mcPlayer.x > stage.stageWidth - mcPlayer.width / 2)
			{
				// Set our player to the right of the stage
				mcPlayer.x = stage.stageWidth - mcPlayer.width / 2;
			}
		}
		
		private function playerControl():void 
		{
			// If our left key is currently down
			if (leftKeyIsDown)
			{
				// move our player to the left
				mcPlayer.x -= 5;
			}
			// If our right key is currently down
			if (rightKeyIsDown)
			{
				// move our player to the right
				mcPlayer.x += 5;
			}
		}

		private function keyUp(e:KeyboardEvent):void 
		{
			// If our left key is released
			if (e.keyCode == Keyboard.LEFT)
			{
				leftKeyIsDown = false;
			}
			// If our right key is released
			if (e.keyCode == Keyboard.RIGHT)
			{
				rightKeyIsDown = false;
			}
			if (e.keyCode == Keyboard.SPACE)
			{
				// fire a missile
				fireMissile();
			}
		}
		
		private function fireMissile():void 
		{
			// Create a new missile object
			var newMissile:Missile = new Missile();
			
			// Add that missile object to the stage
			stage.addChild(newMissile);
			
			// Position our missile so it's on top of our player object
			newMissile.x = mcPlayer.x;
			newMissile.y = mcPlayer.y;
			
			// Add the new missile to our missile array
			aMissileArray.push(newMissile);
			trace(aMissileArray.length);
		}

		private function keyDown(e:KeyboardEvent):void
		{
			// If our left key is pressed
			if (e.keyCode == Keyboard.LEFT)
			{
				leftKeyIsDown = true;
			}
			// If our right key is pressed
			if (e.keyCode == Keyboard.RIGHT)
			{
				rightKeyIsDown = true;
			}
		}
		
	}

}