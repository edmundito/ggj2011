package states 
{
	import org.flixel.*;
	import states.GameState;
	
	public class MainMenuState extends FlxState 
	{
		
		override public function create():void 
		{
			var logo:FlxSprite = new FlxSprite(5, 0, Assets.TitleGraphic);
			add(logo);
			
			super.create();
			
			FlxG.flash.start(0xff000000, 1.0);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("S"))
			{
				FlxG.state = new GameState();
			}
		}
		
	}

}