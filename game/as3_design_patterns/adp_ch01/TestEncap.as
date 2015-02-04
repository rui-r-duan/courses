package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class TestEncap extends Sprite 
	{
		public var encap:Encap;
		public function TestEncap() 
		{
			super();
			encap = new Encap();
			//encap.dogTalk = "Meow";
			encap.showDogTalk();
			addChild(encap);
		}
		
	}

}