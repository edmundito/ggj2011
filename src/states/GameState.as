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
			
			_player1Strip = new PlayerGroup();
			_player1Strip.y = FlxG.height * 0.5 - 100;
			add(_player1Strip);
			
			_player2Strip = new PlayerGroup();
			_player2Strip.y = FlxG.height - 100;
			add(_player2Strip);
		}
		
	}
}