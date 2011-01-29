package states 
{
	import org.flixel.*;
	
	public class GameState extends FlxState 
	{
		
		public function GameState() 
		{
			// State name
			add(new FlxText(0, 0, 100, "Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
		}
		
	}
}