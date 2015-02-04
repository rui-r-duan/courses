package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class SendFlowers extends Sprite 
	{
		
		public function SendFlowers() 
		{
			super();
			var trueLove:FlowerShop = new FlowerShop();
			//Set values
			trueLove.flowers = "A dozen roses";
			//Get values
			trace(trueLove.flowers);
			//Set different values
			trueLove.flowers = "And a dozen more....";
			//Get the chaged values
			trace(trueLove.flowers);
		}
		
	}

}