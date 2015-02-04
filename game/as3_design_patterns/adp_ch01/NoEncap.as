package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	// This is BAD OOP -- No encapsulation
	public class NoEncap extends Sprite
	{
		public var dogTalk:String = "Woof, woof!";
		public var textFld:TextField = new TextField();
		
		public function NoEncap()
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