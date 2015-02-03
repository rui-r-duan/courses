package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	// This is BAD OOP -- No encapsulation
	public class Encap extends Sprite
	{
		private var dogTalk:String = "Woof, woof!";
		private var textFld:TextField = new TextField();
		
		public function Encap()
		{
			addChild(textFld);
			textFld.x = 100;
			textFld.y = 100;
		}
		
		function showDogTalk()
		{
			textFld.text = dogTalk;
		}
	}
}