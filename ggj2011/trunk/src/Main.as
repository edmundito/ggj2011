package 
{
	import org.flixel.*;
	import states.*;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{
		public function Main():void 
		{
			super(320, 240, GameState, 2);
			
			FlxG.mouse.show();
		}
	}
}
