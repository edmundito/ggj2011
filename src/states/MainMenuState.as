package states 
{
	import org.flixel.*;
	import states.GameState;
	
	public class MainMenuState extends FlxState 
	{
		
		override public function create():void 
		{
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Here comes teh Sun!");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
 
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Play");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			FlxG.flash.start(0xff000000, 0.2);
			
			super.create();
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.state = new GameState();
			}
 
		}
		
	}

}