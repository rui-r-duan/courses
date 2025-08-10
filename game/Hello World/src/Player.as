package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class Player extends Entity 
	{
		[Embed(source = "../assets/sample-sprite.png")]
		private const PLAYER:Class;
		
		[Embed(source="../assets/shoot.mp3")]
		private const SHOOT:Class;

		public var shoot:Sfx = new Sfx(SHOOT);
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(PLAYER);
			super(x, y, graphic, mask);
			Input.define("Jump", Key.Z, Key.UP);
			Input.define("Shoot", Key.SPACE, Key.X, Key.C);
			setHitbox(50, 50);
		}
		
		override public function update():void
		{
			if (Input.check(Key.LEFT)) { x -= 5; }
			if (Input.check(Key.RIGHT)) { x += 5; }
			if (Input.check(Key.UP)) { y -= 5; }
			if (Input.check(Key.DOWN)) { y += 5; }
			if (Input.pressed("Jump")) { y -= 5; }
			if (Input.pressed("Shoot")) { trace("shoot") }
			
			// Assigns the Entity's position to that of the mouse (relative to the Camera).
			x = Input.mouseX;
			y = Input.mouseY;
			// Assigns the Entity's position to that of the mouse (relative to the World).
			//x = FP.world.mouseX;
			//y = FP.world.mouseY;
			
			// Assign the collided Bullet Entity to a temporary var.
			var b:Bullet = collide("bullet", x, y) as Bullet;

			// Check if b has a value (true if a Bullet was collided with).
			if (b)
			{
				// Call the Bullet's destroy() function.
				b.destroy();
				trace("collide with bullet");
			}
			
			if (Input.mouseDown)
			{
				shoot.play();
			}
		}
	}

}