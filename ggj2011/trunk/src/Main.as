package 
{
	import org.flixel.*;
	import states.*;

	[SWF(width="960", height="640", backgroundColor="#000000")]
	
	public class Main extends FlxGame
	{
		public function Main ():void 
		{
			// change to intro menu
			super (480, 320, GameState, 2);
		}
	}
}