package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class TestRocket extends Sprite 
	{
		private var fireRocket:FireRocket;
		public function TestRocket()
		{
			fireRocket = new FireRocket();
			fireRocket.x = 50;
			fireRocket.y = 100;
			addChild(fireRocket);
			fireRocket.gotoAndPlay(2);
		}
	}
	
}