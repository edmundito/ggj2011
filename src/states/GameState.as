package states 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * Temp starting point
	 * @author tedo
	 */
	public class GameState extends FlxState 
	{
		
		override public function create():void
		{
			add(new FlxText(0, 0, 100, "Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
		}
		
	}

}