package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class Main extends Engine 
	{
		
		public function Main() 
		{
			super(800, 600, 60, true);
			trace("Hello, world!");
			FP.world = new MyWorld;
			Input.mouseCursor = "hide";
		}
		
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
		
	}
	
}