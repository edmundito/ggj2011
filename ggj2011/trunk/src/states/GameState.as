package states 
{
	import org.flixel.*;
	
	import sprites.*;
	
	import world.*;
	
	public class GameState extends FlxState 
	{
		private var _player1Strip:PlayerGroup;
		private var _player2Strip:PlayerGroup;
		
		private var _figure:FigureSprite;
		
		override public function create():void
		{
			
			// State name
			add(new FlxText(0, 0, 100, "Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			var player1:PlayerSprite = new PlayerSprite("blue", "L", "A", FlxSprite.RIGHT, 20, 50);
			var player2:PlayerSprite = new PlayerSprite("red", "G", "H", FlxSprite.LEFT, FlxG.width - 20, 50);
			
			_player1Strip = new PlayerGroup(player1);
			_player1Strip.y = FlxG.height * 0.5 - 100;
			add(_player1Strip);
			
			_player2Strip = new PlayerGroup(player2);
			_player2Strip.y = FlxG.height - 100;
			add(_player2Strip);
			
			
			_figure = new FigureSprite(FlxG.width * 0.5, FlxG.height * 0.5, Assets.BlueBirthGraphic, 16);
			add(_figure);
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("B"))
			{
				_figure.buildStep();
			}
			
			super.update();
		}
		
	}
}