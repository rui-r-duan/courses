package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class SwordGuy extends Entity 
	{
		[Embed(source = "../assets/swordguy.png")]
		private const SWORDGUY:Class;
		
		public var sprSwordguy:Spritemap = new Spritemap(SWORDGUY, 48, 32);
		
		public function SwordGuy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = sprSwordguy;
			super(x, y, graphic, mask);
			sprSwordguy.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			sprSwordguy.add("run", [6, 7, 8, 9, 10, 11], 20, true);
		}
		
		override public function update():void
		{
			x = Input.mouseX;
			y = Input.mouseY;
			if (Input.mousePressed)
			{
				sprSwordguy.play("run");
			}
			if (Input.mouseReleased)
			{
				sprSwordguy.play("stand");
			}
		}
	}

}