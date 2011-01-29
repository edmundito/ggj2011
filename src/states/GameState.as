package states 
{
	import org.flixel.*;
	
	import sprites.PlayerSprite;
	
	import world.*;
	
	public class GameState extends FlxState 
	{
		private var _player1Strip:PlayerGroup;
		private var _player2Strip:PlayerGroup;
		
		public function GameState() 
		{
			// State name
			add(new FlxText(0, 0, 100, "Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			var player1:PlayerSprite = new PlayerSprite("L", "A", FlxSprite.RIGHT, 20, 50);
			var player2:PlayerSprite = new PlayerSprite("G", "H", FlxSprite.LEFT, FlxG.width - 20, 50);
			
			_player1Strip = new PlayerGroup(player1);
			_player1Strip.y = FlxG.height * 0.5 - 100;
			add(_player1Strip);
			
			_player2Strip = new PlayerGroup(player2);
			_player2Strip.y = FlxG.height - 100;
			add(_player2Strip);
		}
		
	}
}