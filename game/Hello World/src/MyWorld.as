package 
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class MyWorld extends World 
	{
		
		public function MyWorld() 
		{
			//add(new Player());
			add(new SwordGuy());
		}
		
	}

}