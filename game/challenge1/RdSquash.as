package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class RdSquash extends MovieClip 
	{
		var leftbutton: Boolean = false;
		var rightbutton: Boolean = false;
		var boolean_ball: Boolean;
		var boolean_click: Boolean = true;
		var boolean_movement: Boolean;
		var speed_control: int;
		var speed_x: int = 10;
		var speed_y: int = 10;
		var angle: int;
		var score: int;
		var txt_score: TextField = new TextField;
		var newFormat: TextFormat = new TextFormat();

		public function RdSquash() {
			super();
			stop();
			ball.addEventListener(MouseEvent.CLICK, controlBoard);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keycontrol);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		private function gameLoop(e:Event):void 
		{
			init();
			if (ball.y < stage.stageHeight - (ball.height / 2)) {

				collision();
			}

			if (ball.y > stage.stageHeight - (ball.height / 2)) {
				ball.x = 290;
				ball.y = 200;
				boolean_click = true;

				boolean_movement = false;
				speed_control = 0;
				speed_x = 10;
				speed_y = 10;
				score = 0;


			}
			if (boolean_ball) {

				if (mouseX - player1.width / 2 < 16) {
					player1.x = 46;
				} else if (mouseX - player1.width / 2 > 239) {
					player1.x = 269;
				} else {
					player1.x = mouseX;
				}
				if (mouseY - player1.height / 2 < 280) {
					player1.y = 304;
				} else if (mouseY - player1.height / 2 > 353) {
					player1.y = 377;
				} else {
					player1.y = mouseY;
				}
			}
			txt_score.text = score.toString();
		}
		
		private function keycontrol(e:KeyboardEvent):void 
		{
			//if ((player2.x >= 330) && (player2.x <= 570) && (player2.y >= 310) && (player2.y <= 380)) {
				switch (e.keyCode) {
					case Keyboard.LEFT:
						player2.x -= 10;
						break;
					case Keyboard.RIGHT:
						player2.x += 10;
						break;
					case Keyboard.UP:
						player2.y -= 10;
						break;
					case Keyboard.DOWN:
						player2.y += 10;
						break;
				}
				if (player2.x < leftboard.x) {
					player2.x = leftboard.x;
				}
				if (player2.x > rightboard.x + rightboard.width) {
					player2.x = rightboard.x + rightboard.width - 1;
				}
				if (player2.y < 282) {
					player2.y = 284;
				}
				if (player2.y > 380) {
					player2.y = 378;
				}
			//}
		}
		
		private function controlBoard(e:Event):void {
			if (boolean_click) {
				angle = Math.random() * 120 + 210;
				boolean_ball = true;
				boolean_movement = true;
				boolean_click = false;
				
				if (speed_y < 0) {
				speed_y = -speed_y;
				}
			}
		}
		
		function collision(): void {
			if (boolean_movement) {
				ball.x += speed_x * Math.cos(angle * (Math.PI / 180));
				ball.y += speed_y * Math.sin(angle * (Math.PI / 180));
			}

			if (ball.hitTestObject(leftboard) || ball.hitTestObject(rightboard)) {
				speed_control += 10;

				speed_x = -speed_x;
				if (speed_x > 0) {
					speed_x = Math.abs(Math.floor(speed_control / 100)) * 5 + 10;
				} else {
					speed_x = -Math.abs(Math.floor(speed_control / 100)) * 5 - 10;
				}
				if ((angle > 260 && angle < 270) || angle == 270 || (angle > 335 && angle < 360)) {
					angle -= 13;
				}
				if ((angle > 270 && angle < 280) || (angle > 180 && angle < 205)) {

					angle += 13;
				}
			}

			if (ball.hitTestObject(topboard)) {
				speed_control += 10;

				speed_y = -speed_y;
				if (speed_y > 0) {
					speed_y = Math.abs(Math.floor(speed_control / 100)) * 5 + 10;
				} else {
					speed_y = -Math.abs(Math.floor(speed_control / 100)) * 5 - 10;
				}
			}
			if (ball.hitTestObject(player1)) {
				if (speed_y < 0) {
					speed_y = Math.abs(Math.floor(speed_control / 100)) * 5 + 10;
					speed_control += 10;
					score += 10;

				}
				if (ball.x < player1.x - 10) {
					if ((angle > 260 && angle < 270) || angle == 270 || (angle > 345 && angle < 360)) {
						angle -= 12;
					} else
						angle += 12;
				}
				if (ball.x > player1.x + 10) {
					if ((angle > 270 && angle < 280) || (angle > 180 && angle < 195)) {
						angle += 11;
					} else
						angle -= 12;
				}


			}
			if (ball.hitTestObject(player2)) {
				if (speed_y < 0) {
					speed_y = Math.abs(Math.floor(speed_control / 100)) * 5 + 10;
					speed_control += 10;
					score += 10;

				}
				if (ball.x < player2.x - 10) {
					if ((angle > 260 && angle < 270) || angle == 270 || (angle > 345 && angle < 360)) {
						angle -= 12;
					} else
						angle += 12;
				}
				if (ball.x > player2.x + 10) {
					if ((angle > 270 && angle < 280) || (angle > 180 && angle < 195)) {
						angle += 11;
					} else
						angle -= 12;
				}
			}
		} // end colission
		
		function init() {
			newFormat.size = 30;
			newFormat.color = 0x000000;
			txt_score.setTextFormat(newFormat);
			addChild(txt_score);
			txt_score.x = 120;
			txt_score.y = topboard.y + topboard.height + 10;
			txt_score.width = 100;
			txt_score.height = 40;
		}
	}
}