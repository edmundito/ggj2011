package states 
{
	import org.flixel.*;
	
	import sprites.*;
	
	import world.*;
	
	public class GameState extends FlxState 
	{
		private var _player1:PlayerSprite;
		private var _player2:PlayerSprite;
		
		private var _player1Strip:PlayerGroup;
		private var _player2Strip:PlayerGroup;
		
		private var _figure:FigureSprite;
		
		override public function create():void
		{
			
			// State name
			add(new FlxText(0, 0, 100, "Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			_player1 = new PlayerSprite("blue", "L", "A", FlxSprite.RIGHT, 20, 90);
			_player2 = new PlayerSprite("red", "H", "G", FlxSprite.RIGHT, 20, 90);
			
			_player1Strip = new PlayerGroup(_player1);
			_player1Strip.y = 0;
			add(_player1Strip);
			
			_player2Strip = new PlayerGroup(_player2);
			_player2Strip.y = FlxG.height * 0.5;
			add(_player2Strip);
			
			
			_figure = new FigureSprite(FlxG.width * 0.5, FlxG.height * 0.5, Assets.BluePlayerGraphic, 16);
			add(_figure);
			
			_player1.state = PlayerSprite.STATE_BUILD;
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("B") && !_figure.isDone)
			{
				_figure.buildStep();
				_player1.building();
				
				if (_figure.isDone)
				{
					_player1.state = PlayerSprite.STATE_RUN;
				}
			}
			
			super.update();
		}
		
	}
}