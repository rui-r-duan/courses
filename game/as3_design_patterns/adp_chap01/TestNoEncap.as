package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class TestNoEncap extends Sprite 
	{
		public var noEncap:NoEncap;
		public function TestNoEncap() 
		{
			super();
			noEncap = new NoEncap();
			noEncap.dogTalk = "Meow";
			noEncap.showDogTalk();
			addChild(noEncap);
		}
		
	}

}